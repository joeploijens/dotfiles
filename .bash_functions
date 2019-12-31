#!/usr/bin/env bash
#
# ~/.bash_functions

# Create a data URI from a file.
function datauri() {
  local mimeType

  [[ -z $1 ]] && { echo "${FUNCNAME[0]}: Missing file name"; return 1; }

  if [[ -f "$1" ]]
  then
    mimeType=$(file -b --mime-type "$1")
    if [[ $mimeType == text/* ]]
    then
      mimeType="${mimeType};charset=utf-8"
    fi
    echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
  else
    echo "${FUNCNAME[0]}: $1: Not a file"
    return 1
  fi
}

# Recursively delete files that match a certain pattern from the current
# directory (by default all .DS_Store files are deleted).
deletefiles() {
  local q="${1:-*.DS_Store}"

  find . -type f -name "$q" -ls -delete
} 

# Remove downloaded file(s) from the macOS quarantine.
unquarantine() {
  local attribute

  for attribute in com.apple.metadata:kMDItemDownloadedDate \
                   com.apple.metadata:kMDItemWhereFroms \
                   com.apple.quarantine \
                   com.apple.lastuseddate#PS
  do
    xattr -rd "$attribute" "$@"
  done
}

# Create a spectrogram of an audio file.
spectrogram() {
  [[ -z $1 ]] && { echo "${FUNCNAME[0]}: Missing file name"; return 1; }

  if [[ -f "$1" ]]
  then
    sox "$1" -n spectrogram -o "${HOME}/Desktop/${1##*/}.png"
  else
    echo "${FUNCNAME[0]}: $1: Not a file"
    return 1
  fi
}

# Image manipulation functions.
if [[ -n $(command -v gm) ]]
then
  gm-convert2srgb() {
    [[ $# -ne 2 ]] && { echo "Usage: ${FUNCNAME[0]} input.jpg output.jpg"; return 1; }
    gm convert "$1" -profile "/System/Library/ColorSync/Profiles/sRGB Profile.icc" -strip -define jpeg:preserve-settings "$2"
  }

  gm-resize() {
    [[ $# -ne 3 ]] && { echo "Usage: ${FUNCNAME[0]} input.jpg output.jpg size"; return 1; }
    gm convert "$1" -filter Lanczos -geometry "${3}x" -define jpeg:preserve-settings "$2"
  }
fi

jpg-compress() {
  [[ $# -ne 2 ]] && { echo "Usage: ${FUNCNAME[0]} input.jpg output.jpg"; return 1; }
  djpeg -dct float "$1" | cjpeg -quality 94 -sample 1x1,1x1,1x1 -optimize -dct float -outfile "$2"
}

jpg-optim() {
  [[ $# -ne 2 ]] && { echo "Usage: ${FUNCNAME[0]} input.jpg output.jpg"; return 1; }
  jpegtran -copy none -optimize -perfect -outfile "$2" "$1"
}
