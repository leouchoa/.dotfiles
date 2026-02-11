package main

import (
	"errors"
	"flag"
	"fmt"
	"io"
	"io/fs"
	"os"
	"path/filepath"
	"sort"
	"strings"
	"time"
	"unicode"
)

const (
	version               = "0.1.0"
	defaultResultsDirName = "results"
)

type cleanOptions struct {
	dir               string
	resultsDir        string
	recursive         bool
	removePunctuation bool
	dryRun            bool
	overwrite         bool
	files             []string
}

type summary struct {
	total     int
	changed   int
	unchanged int
	skipped   int
	failed    int
}

func main() {
	os.Exit(run(os.Args[1:], os.Stdout, os.Stderr))
}

func run(args []string, stdout, stderr io.Writer) int {
	if len(args) > 0 {
		switch args[0] {
		case "completion":
			return runCompletion(args[1:], stdout, stderr)
		case "help", "--help", "-h":
			printUsage(stdout)
			return 0
		case "version", "--version", "-v":
			fmt.Fprintln(stdout, version)
			return 0
		}
	}

	fsFlags := flag.NewFlagSet("fclear", flag.ContinueOnError)
	fsFlags.SetOutput(stderr)

	var opts cleanOptions
	var showVersion bool
	fsFlags.StringVar(&opts.dir, "dir", "", "directory to process")
	fsFlags.StringVar(&opts.resultsDir, "results-dir", "", "directory for cleaned copies (default: <dir>/results)")
	fsFlags.BoolVar(&opts.recursive, "recursive", false, "recursively process files under --dir")
	fsFlags.BoolVar(&opts.removePunctuation, "rm-punct", false, "remove punctuation characters")
	fsFlags.BoolVar(&opts.dryRun, "dry-run", false, "preview changes without modifying files")
	fsFlags.BoolVar(&opts.overwrite, "overwrite", false, "rename files in place instead of copying")
	fsFlags.BoolVar(&showVersion, "version", false, "print version and exit")
	fsFlags.Usage = func() {
		printUsage(stderr)
	}

	if err := fsFlags.Parse(args); err != nil {
		return 2
	}
	if showVersion {
		fmt.Fprintln(stdout, version)
		return 0
	}

	opts.files = fsFlags.Args()
	if err := opts.validate(); err != nil {
		fmt.Fprintf(stderr, "Error: %v\n", err)
		printUsage(stderr)
		return 2
	}

	sum := execute(opts, stdout, stderr)
	if sum.failed > 0 {
		return 1
	}
	return 0
}

func (o *cleanOptions) validate() error {
	if o.dir == "" && len(o.files) == 0 {
		return errors.New("provide --dir or one or more file paths")
	}
	if o.overwrite && o.resultsDir != "" {
		return errors.New("--results-dir cannot be used with --overwrite")
	}
	return nil
}

func execute(opts cleanOptions, stdout, stderr io.Writer) summary {
	var sum summary
	usedTargets := map[string]struct{}{}

	dirMode := opts.dir != ""
	var sourceDir string
	var resultsDir string
	var err error

	if dirMode {
		sourceDir, err = expandPath(opts.dir)
		if err != nil {
			fmt.Fprintf(stderr, "ERROR: %v\n", err)
			sum.failed++
			return sum
		}
		info, statErr := os.Stat(sourceDir)
		if statErr != nil {
			fmt.Fprintf(stderr, "ERROR: cannot access directory %q: %v\n", sourceDir, statErr)
			sum.failed++
			return sum
		}
		if !info.IsDir() {
			fmt.Fprintf(stderr, "ERROR: --dir is not a directory: %s\n", sourceDir)
			sum.failed++
			return sum
		}

		if !opts.overwrite {
			resultsDir = opts.resultsDir
			if resultsDir == "" {
				resultsDir = filepath.Join(sourceDir, defaultResultsDirName)
			}
			resultsDir, err = expandPath(resultsDir)
			if err != nil {
				fmt.Fprintf(stderr, "ERROR: %v\n", err)
				sum.failed++
				return sum
			}
			resultsDir = filepath.Clean(resultsDir)
			sourceDirClean := filepath.Clean(sourceDir)
			if samePath(resultsDir, sourceDirClean) {
				fmt.Fprintf(stderr, "ERROR: results directory cannot be the same as source directory\n")
				sum.failed++
				return sum
			}
			if !opts.dryRun {
				if mkErr := os.MkdirAll(resultsDir, 0o755); mkErr != nil {
					fmt.Fprintf(stderr, "ERROR: failed to create results directory %q: %v\n", resultsDir, mkErr)
					sum.failed++
					return sum
				}
			}
			fmt.Fprintf(stderr, "INFO: copy mode enabled; output directory: %s\n", resultsDir)
		}
	}

	inputs, collectErr := collectInputs(opts, sourceDir, resultsDir)
	if collectErr != nil {
		fmt.Fprintf(stderr, "ERROR: %v\n", collectErr)
		sum.failed++
		return sum
	}
	sort.Strings(inputs)
	sum.total = len(inputs)
	if sum.total == 0 {
		fmt.Fprintln(stderr, "INFO: no files matched the selection")
		return sum
	}

	if opts.dryRun {
		fmt.Fprintln(stderr, "INFO: dry-run enabled (no file changes)")
	}

	for _, input := range inputs {
		srcPath, pathErr := expandPath(input)
		if pathErr != nil {
			fmt.Fprintf(stderr, "SKIP: %v\n", pathErr)
			sum.skipped++
			continue
		}
		srcPath = filepath.Clean(srcPath)
		srcInfo, statErr := os.Stat(srcPath)
		if statErr != nil {
			fmt.Fprintf(stderr, "SKIP: cannot stat %q: %v\n", srcPath, statErr)
			sum.skipped++
			continue
		}
		if srcInfo.IsDir() {
			fmt.Fprintf(stderr, "SKIP: directory path provided (use --dir): %s\n", srcPath)
			sum.skipped++
			continue
		}

		origName := filepath.Base(srcPath)
		cleanName := cleanFilename(origName, opts.removePunctuation)
		if cleanName == origName {
			sum.unchanged++
			continue
		}

		dstDir := filepath.Dir(srcPath)
		if dirMode && !opts.overwrite {
			dstDir = resultsDir
		}
		desiredPath := filepath.Join(dstDir, cleanName)
		finalPath, collision, resolveErr := resolveTargetPath(desiredPath, srcPath, usedTargets)
		if resolveErr != nil {
			fmt.Fprintf(stderr, "ERROR: cannot resolve output path for %q: %v\n", srcPath, resolveErr)
			sum.failed++
			continue
		}

		if samePath(srcPath, finalPath) {
			sum.unchanged++
			continue
		}

		if dirMode && !opts.overwrite {
			if collision {
				fmt.Fprintf(stderr, "COPY (collision): %s -> %s\n", srcPath, finalPath)
			} else {
				fmt.Fprintf(stderr, "COPY: %s -> %s\n", srcPath, finalPath)
			}
			if opts.dryRun {
				sum.changed++
				continue
			}
			if err := copyFile(srcPath, finalPath, srcInfo.Mode().Perm()); err != nil {
				fmt.Fprintf(stderr, "ERROR: copy failed %q -> %q: %v\n", srcPath, finalPath, err)
				sum.failed++
				continue
			}
			sum.changed++
			continue
		}

		if collision {
			fmt.Fprintf(stderr, "RENAME (collision): %s -> %s\n", srcPath, finalPath)
		} else {
			fmt.Fprintf(stderr, "RENAME: %s -> %s\n", srcPath, finalPath)
		}
		if opts.dryRun {
			sum.changed++
			continue
		}
		if err := renameFile(srcPath, finalPath); err != nil {
			fmt.Fprintf(stderr, "ERROR: rename failed %q -> %q: %v\n", srcPath, finalPath, err)
			sum.failed++
			continue
		}
		sum.changed++
	}

	fmt.Fprintf(
		stderr,
		"SUMMARY: total=%d changed=%d unchanged=%d skipped=%d failed=%d\n",
		sum.total,
		sum.changed,
		sum.unchanged,
		sum.skipped,
		sum.failed,
	)
	return sum
}

func collectInputs(opts cleanOptions, sourceDir, resultsDir string) ([]string, error) {
	var inputs []string
	if sourceDir != "" {
		list, err := listFiles(sourceDir, opts.recursive, resultsDir)
		if err != nil {
			return nil, err
		}
		inputs = append(inputs, list...)
	}
	for _, item := range opts.files {
		expanded, err := expandPath(item)
		if err != nil {
			return nil, err
		}
		inputs = append(inputs, expanded)
	}
	return inputs, nil
}

func listFiles(root string, recursive bool, skipDir string) ([]string, error) {
	var files []string

	if !recursive {
		entries, err := os.ReadDir(root)
		if err != nil {
			return nil, fmt.Errorf("read directory %q: %w", root, err)
		}
		for _, entry := range entries {
			if entry.IsDir() {
				continue
			}
			files = append(files, filepath.Join(root, entry.Name()))
		}
		return files, nil
	}

	skipDirClean := filepath.Clean(skipDir)
	err := filepath.WalkDir(root, func(path string, d fs.DirEntry, walkErr error) error {
		if walkErr != nil {
			return walkErr
		}
		cleanPath := filepath.Clean(path)
		if d.IsDir() {
			if skipDirClean != "" && samePath(cleanPath, skipDirClean) {
				return filepath.SkipDir
			}
			return nil
		}
		files = append(files, cleanPath)
		return nil
	})
	if err != nil {
		return nil, fmt.Errorf("walk directory %q: %w", root, err)
	}
	return files, nil
}

func cleanFilename(name string, removePunctuation bool) string {
	name = strings.TrimSpace(name)
	if name == "" {
		return "unnamed"
	}

	hidden := strings.HasPrefix(name, ".") && len(name) > 1
	ext := filepath.Ext(name)
	if ext == "." {
		ext = ""
	}
	base := strings.TrimSuffix(name, ext)
	base = strings.TrimSpace(base)
	base = strings.Join(strings.Fields(base), "_")

	if removePunctuation {
		base = removeAllPunctuation(base)
	}
	base = removeUnsafeCharacters(base)
	base = collapseRepeatedRune(base, '_')
	base = strings.Trim(base, "._- ")
	base = strings.ToLower(base)

	if base == "" {
		base = "unnamed"
	}
	if isWindowsReservedName(base) {
		base = "_" + base
	}
	if hidden && !strings.HasPrefix(base, ".") {
		base = "." + base
	}

	ext = strings.ToLower(ext)
	return base + ext
}

func removeAllPunctuation(s string) string {
	var b strings.Builder
	b.Grow(len(s))
	for _, r := range s {
		switch {
		case r == '_' || r == '-' || r == '.':
			b.WriteRune(r)
		case unicode.IsPunct(r):
			// drop
		default:
			b.WriteRune(r)
		}
	}
	return b.String()
}

func removeUnsafeCharacters(s string) string {
	var b strings.Builder
	b.Grow(len(s))
	for _, r := range s {
		switch {
		case unicode.IsLetter(r), unicode.IsDigit(r):
			b.WriteRune(r)
		case r == '_' || r == '-' || r == '.':
			b.WriteRune(r)
		case unicode.IsSpace(r):
			b.WriteRune('_')
		}
	}
	return b.String()
}

func collapseRepeatedRune(s string, target rune) string {
	var b strings.Builder
	b.Grow(len(s))

	var last rune
	hasLast := false
	for _, r := range s {
		if hasLast && r == target && last == target {
			continue
		}
		b.WriteRune(r)
		last = r
		hasLast = true
	}
	return b.String()
}

func isWindowsReservedName(s string) bool {
	base := strings.ToUpper(strings.TrimSpace(strings.TrimPrefix(s, ".")))
	if base == "" {
		return false
	}
	switch base {
	case "CON", "PRN", "AUX", "NUL":
		return true
	}
	if len(base) == 4 {
		prefix := base[:3]
		suffix := base[3]
		if (prefix == "COM" || prefix == "LPT") && suffix >= '1' && suffix <= '9' {
			return true
		}
	}
	return false
}

func resolveTargetPath(desiredPath, sourcePath string, reserved map[string]struct{}) (string, bool, error) {
	dir := filepath.Dir(desiredPath)
	filename := filepath.Base(desiredPath)
	ext := filepath.Ext(filename)
	stem := strings.TrimSuffix(filename, ext)
	candidate := desiredPath

	for i := 2; ; i++ {
		key := pathKey(candidate)
		if _, exists := reserved[key]; exists {
			candidate = filepath.Join(dir, fmt.Sprintf("%s_%d%s", stem, i, ext))
			continue
		}

		exists, sameAsSource, err := pathExistsAndIsSameFile(candidate, sourcePath)
		if err != nil {
			return "", false, err
		}
		if exists && !sameAsSource {
			candidate = filepath.Join(dir, fmt.Sprintf("%s_%d%s", stem, i, ext))
			continue
		}

		reserved[key] = struct{}{}
		return candidate, !samePath(candidate, desiredPath), nil
	}
}

func pathExistsAndIsSameFile(path, sourcePath string) (exists bool, same bool, err error) {
	pathInfo, pathErr := os.Stat(path)
	if pathErr != nil {
		if errors.Is(pathErr, os.ErrNotExist) {
			return false, false, nil
		}
		return false, false, pathErr
	}
	if sourcePath == "" {
		return true, false, nil
	}
	sourceInfo, srcErr := os.Stat(sourcePath)
	if srcErr != nil {
		if errors.Is(srcErr, os.ErrNotExist) {
			return true, false, nil
		}
		return true, false, srcErr
	}
	return true, os.SameFile(pathInfo, sourceInfo), nil
}

func renameFile(src, dst string) error {
	if samePath(src, dst) {
		return nil
	}
	if err := os.Rename(src, dst); err == nil {
		return nil
	}

	// macOS default filesystems are case-insensitive. Case-only renames can fail
	// when the destination looks like the same path to the filesystem.
	if samePathFold(filepath.Dir(src), filepath.Dir(dst)) &&
		strings.EqualFold(filepath.Base(src), filepath.Base(dst)) {
		tmp := filepath.Join(
			filepath.Dir(src),
			fmt.Sprintf(".fclear_tmp_%d_%s", time.Now().UnixNano(), filepath.Base(src)),
		)
		if err := os.Rename(src, tmp); err != nil {
			return err
		}
		if err := os.Rename(tmp, dst); err != nil {
			_ = os.Rename(tmp, src)
			return err
		}
		return nil
	}
	return os.Rename(src, dst)
}

func copyFile(src, dst string, mode fs.FileMode) error {
	in, err := os.Open(src)
	if err != nil {
		return err
	}
	defer in.Close()

	out, err := os.OpenFile(dst, os.O_CREATE|os.O_WRONLY|os.O_TRUNC, mode)
	if err != nil {
		return err
	}
	defer out.Close()

	if _, err := io.Copy(out, in); err != nil {
		return err
	}
	return out.Sync()
}

func expandPath(path string) (string, error) {
	if path == "" {
		return "", nil
	}
	if path == "~" {
		home, err := os.UserHomeDir()
		if err != nil {
			return "", fmt.Errorf("cannot resolve home directory: %w", err)
		}
		return home, nil
	}
	if strings.HasPrefix(path, "~/") {
		home, err := os.UserHomeDir()
		if err != nil {
			return "", fmt.Errorf("cannot resolve home directory: %w", err)
		}
		return filepath.Join(home, strings.TrimPrefix(path, "~/")), nil
	}
	return path, nil
}

func samePath(a, b string) bool {
	return filepath.Clean(a) == filepath.Clean(b)
}

func samePathFold(a, b string) bool {
	return strings.EqualFold(filepath.Clean(a), filepath.Clean(b))
}

func pathKey(path string) string {
	return strings.ToLower(filepath.Clean(path))
}

func printUsage(w io.Writer) {
	fmt.Fprintf(w, "fclear %s\n", version)
	fmt.Fprintln(w, "Clean file names (spaces/unsafe chars) safely.")
	fmt.Fprintln(w, "")
	fmt.Fprintln(w, "Usage:")
	fmt.Fprintln(w, "  fclear [flags] [file ...]")
	fmt.Fprintln(w, "  fclear completion <zsh|bash|fish>")
	fmt.Fprintln(w, "")
	fmt.Fprintln(w, "Flags:")
	fmt.Fprintln(w, "  --dir <path>         Directory to process")
	fmt.Fprintln(w, "  --recursive          Recurse when using --dir")
	fmt.Fprintln(w, "  --rm-punct           Remove punctuation")
	fmt.Fprintln(w, "  --dry-run            Preview changes without modifying files")
	fmt.Fprintln(w, "  --overwrite          Rename in place (default is copy mode for --dir)")
	fmt.Fprintln(w, "  --results-dir <dir>  Output dir in copy mode (default: <dir>/results)")
	fmt.Fprintln(w, "  --version            Print version")
	fmt.Fprintln(w, "  --help               Show this help")
	fmt.Fprintln(w, "")
	fmt.Fprintln(w, "Examples:")
	fmt.Fprintln(w, "  fclear --dir ~/Downloads")
	fmt.Fprintln(w, "  fclear --dir ~/Downloads --overwrite --rm-punct")
	fmt.Fprintln(w, "  fclear --dry-run \"My File (1).JPG\"")
}

func runCompletion(args []string, stdout, stderr io.Writer) int {
	if len(args) != 1 {
		fmt.Fprintln(stderr, "Usage: fclear completion <zsh|bash|fish>")
		return 2
	}
	switch args[0] {
	case "zsh":
		fmt.Fprint(stdout, zshCompletionScript)
	case "bash":
		fmt.Fprint(stdout, bashCompletionScript)
	case "fish":
		fmt.Fprint(stdout, fishCompletionScript)
	default:
		fmt.Fprintf(stderr, "Unsupported shell %q. Use zsh, bash, or fish.\n", args[0])
		return 2
	}
	return 0
}

const zshCompletionScript = `#compdef fclear
_fclear() {
  local context state line
  typeset -A opt_args

  if (( CURRENT == 2 )); then
    _values 'subcommand' 'completion[Print shell completion script]'
    return
  fi

  if [[ "$words[2]" == "completion" ]]; then
    _arguments '1:shell:(zsh bash fish)'
    return
  fi

  _arguments -s \
    '--dir[Directory to process]:directory:_files -/' \
    '--recursive[Recursively process files under --dir]' \
    '--rm-punct[Remove punctuation]' \
    '--dry-run[Preview changes without modifying files]' \
    '--overwrite[Rename in place]' \
    '--results-dir[Output directory in copy mode]:directory:_files -/' \
    '--version[Print version]' \
    '--help[Show help]' \
    '*:file:_files'
}

compdef _fclear fclear
`

const bashCompletionScript = `_fclear()
{
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  if [[ ${COMP_CWORD} -eq 1 ]]; then
    COMPREPLY=( $(compgen -W "completion --dir --recursive --rm-punct --dry-run --overwrite --results-dir --help --version" -- "$cur") )
    return 0
  fi

  if [[ "${COMP_WORDS[1]}" == "completion" ]]; then
    COMPREPLY=( $(compgen -W "zsh bash fish" -- "$cur") )
    return 0
  fi

  case "$prev" in
    --dir|--results-dir)
      COMPREPLY=( $(compgen -d -- "$cur") )
      return 0
      ;;
  esac

  opts="--dir --recursive --rm-punct --dry-run --overwrite --results-dir --help --version"
  COMPREPLY=( $(compgen -W "${opts}" -- "$cur") )
}
complete -F _fclear fclear
`

const fishCompletionScript = `complete -c fclear -f
complete -c fclear -l dir -d "Directory to process" -r -a "(__fish_complete_directories)"
complete -c fclear -l recursive -d "Recursively process files under --dir"
complete -c fclear -l rm-punct -d "Remove punctuation"
complete -c fclear -l dry-run -d "Preview changes without modifying files"
complete -c fclear -l overwrite -d "Rename files in place"
complete -c fclear -l results-dir -d "Output directory in copy mode" -r -a "(__fish_complete_directories)"
complete -c fclear -l help -d "Show help"
complete -c fclear -l version -d "Print version"
complete -c fclear -n "__fish_use_subcommand" -a "completion" -d "Print shell completion script"
complete -c fclear -n "__fish_seen_subcommand_from completion" -a "zsh bash fish"
`
