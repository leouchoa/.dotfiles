for file in ~/.{bash_prompt,aliases}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

#https://unix.stackexchange.com/a/38475
#case $- in *i*) . ~/.bashrc;; esac
