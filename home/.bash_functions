#!/usr/bin/env bash
#
# ~/.bash_functions

# Create a data URI from a file
function datauri() {
  local mimeType

  [[ -z $1 ]] && { echo "$FUNCNAME: Missing file name"; return 1; }

  if [[ -f "$1" ]]
  then
    mimeType=$(file -b --mime-type "$1")
    if [[ $mimeType == text/* ]]
    then
      mimeType="${mimeType};charset=utf-8"
    fi
    echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
  else
    echo "$FUNCNAME: $1: Not a file"
    return 1
  fi
}

# Recursively delete files that match a certain pattern from the current
# directory (by default all .DS_Store files are deleted)
deletefiles() {
  local q="${1:-*.DS_Store}"

  find . -type f -name "$q" -ls -delete
} 

# Remove downloaded file(s) from the macOS quarantine
unquarantine() {
  local attribute

  for attribute in com.apple.metadata:kMDItemDownloadedDate com.apple.metadata:kMDItemWhereFroms com.apple.quarantine
  do
    xattr -rd "$attribute" "$@"
  done
}
