#!/bin/bash
# https://seb.jambor.dev/posts/improving-shell-workflows-with-fzf/

function delete-branches() {
  git branch |
    grep --invert-match '\*' |
    cut -c 3- |
    fzf --multi --preview="git log {} --" |
    xargs --no-run-if-empty git branch --delete --force
}
