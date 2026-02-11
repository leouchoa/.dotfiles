package main

import (
	"os"
	"path/filepath"
	"testing"
)

func TestCleanFilename(t *testing.T) {
	t.Parallel()

	tests := []struct {
		name      string
		input     string
		rmPunct   bool
		wantClean string
	}{
		{name: "spaces and case", input: "  My File Name.JPG  ", rmPunct: false, wantClean: "my_file_name.jpg"},
		{name: "remove punctuation", input: "my file (final)!.pdf", rmPunct: true, wantClean: "my_file_final.pdf"},
		{name: "unsafe characters", input: `x:y*z?.txt`, rmPunct: false, wantClean: "xyz.txt"},
		{name: "hidden file", input: ".env.local", rmPunct: false, wantClean: ".env.local"},
		{name: "windows reserved", input: "CON.txt", rmPunct: false, wantClean: "_con.txt"},
		{name: "empty fallback", input: "   ", rmPunct: false, wantClean: "unnamed"},
	}

	for _, tc := range tests {
		tc := tc
		t.Run(tc.name, func(t *testing.T) {
			t.Parallel()
			got := cleanFilename(tc.input, tc.rmPunct)
			if got != tc.wantClean {
				t.Fatalf("cleanFilename(%q) = %q, want %q", tc.input, got, tc.wantClean)
			}
		})
	}
}

func TestResolveTargetPathCollision(t *testing.T) {
	t.Parallel()

	dir := t.TempDir()
	existing := filepath.Join(dir, "photo.jpg")
	if err := os.WriteFile(existing, []byte("a"), 0o644); err != nil {
		t.Fatalf("write existing file: %v", err)
	}

	reserved := map[string]struct{}{}
	got, collision, err := resolveTargetPath(existing, filepath.Join(dir, "source.jpg"), reserved)
	if err != nil {
		t.Fatalf("resolveTargetPath error: %v", err)
	}
	want := filepath.Join(dir, "photo_2.jpg")
	if got != want {
		t.Fatalf("resolveTargetPath got %q, want %q", got, want)
	}
	if !collision {
		t.Fatalf("expected collision=true")
	}
}

func TestResolveTargetPathSameSourceAllowed(t *testing.T) {
	t.Parallel()

	dir := t.TempDir()
	src := filepath.Join(dir, "same.txt")
	if err := os.WriteFile(src, []byte("a"), 0o644); err != nil {
		t.Fatalf("write source file: %v", err)
	}

	reserved := map[string]struct{}{}
	got, collision, err := resolveTargetPath(src, src, reserved)
	if err != nil {
		t.Fatalf("resolveTargetPath error: %v", err)
	}
	if got != src {
		t.Fatalf("resolveTargetPath got %q, want %q", got, src)
	}
	if collision {
		t.Fatalf("expected collision=false")
	}
}
