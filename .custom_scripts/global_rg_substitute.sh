#!/bin/bash

function global_rg(){

  # read -p 'Current text: ' first
  # read -p 'New text: ' second

  read first"?Current text:"
  read second"?New text:"
  # echo Your username is "$username"
  rg --files-with-matches "$first" | fzf --multi --preview "cat {}" | xargs sed -i '' -e "s/$first/$second/"

}
