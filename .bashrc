#!/usr/bin/env bash
#
# ~/.bashrc
#
# Bash startup file for interactive non-login shells.

# If not running interactively, don't do anything.
[[ -z "$PS1" ]] && return

# Shell Options
# ----------------------------------------------------------------------------

# Correct minor errors in the spelling of pathnames when using `cd`.
shopt -s cdspell

# Check the window size after a process completes.
shopt -s checkwinsize

# Append to the history file, rather than overwriting it.
shopt -s histappend

# Enable case-insensitive pattern matching when performing filename expansion.
shopt -s nocaseglob

# Shell Environment
# ----------------------------------------------------------------------------

# Make `vi` the default editor.
export EDITOR=vi

# Don't save duplicate entries on the history list.
export HISTCONTROL=ignoredups

# Commands not to be saved on the history list.
export HISTIGNORE="clear:cls:la:ll:ls:ltr:cd:pwd:exit:date"

# Prefer US English locale and UTF-8 encoding.
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Options for `less`:
#   -i: ignore case when searching
#   -F: automatically quit `less` when the file can be displayed on the first
#       screen
#   -R: display ANSI colors
#   -X: don't clear the screen when quitting
export LESS="-iFRX"

# Make `less` the default pager.
export PAGER=less

# Make `tree` use the same (default) colors as macOS `ls`.
export TREE_COLORS=":no=00:fi=00:di=00;34:ln=00;35:pi=40;33:so=00;32:bd=46;34:cd=43;34:or=40;31;01:ex=00;31:su=00;41:sg=00;46:tw=00;42:ow=00;43:"

# Prompt.
PS1="\u@\h:\w$ "

#
DEVELOPER_DIR="$(xcode-select -p)"

# Git prompt.
# shellcheck disable=SC2034
if [[ -f $DEVELOPER_DIR/usr/share/git-core/git-prompt.sh ]]
then
  source "$DEVELOPER_DIR/usr/share/git-core/git-prompt.sh"
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWSTASHSTATE=1
  GIT_PS1_SHOWCOLORHINTS=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWUPSTREAM=auto
  GIT_PS1_DESCRIBE_STYLE=branch
  GIT_PS1_HIDE_IF_PWD_IGNORED=1
  PROMPT_COMMAND='__git_ps1 "${VIRTUAL_ENV:+(${VIRTUAL_ENV##*/})}\u@\h:\w" "\\$ " " (%s)"'"; $PROMPT_COMMAND"
fi

# Git bash completion.
if [[ -f $DEVELOPER_DIR/usr/share/git-core/git-completion.bash ]]
then
  source "$DEVELOPER_DIR/usr/share/git-core/git-completion.bash"
fi

# Homebrew package manager.
if [[ -n $(command -v brew) ]]
then
  HOMEBREW_PREFIX="$(brew --prefix)"
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_AUTO_UPDATE=1
  export HOMEBREW_TEMP=$TMPDIR

  # Bash completion.
  for file in "$HOMEBREW_PREFIX"/etc/bash_completion.d/*
  do
    source "$file"
  done
  unset file

  # Go.
  if [[ -n $(command -v go) ]]
  then
    export PATH=$PATH:/usr/local/opt/go/libexec/bin
  fi

  # Ruby version management: rbenv and ruby-build.
  if [[ -n $(command -v rbenv) ]]
  then
    export RBENV_ROOT=$HOMEBREW_PREFIX/var/lib/rbenv
    export RUBY_CONFIGURE_OPTS="--disable-install-doc"
    eval "$(rbenv init -)"
  fi

  # Shellcheck.
  if [[ -n $(command -v shellcheck) ]]
  then
    export SHELLCHECK_OPTS='--shell=bash --exclude=SC1090'
  fi

  # Oracle SQL*Plus.
  if [[ -n $(command -v sqlplus) ]]
  then
    export NLS_LANG=AMERICAN_AMERICA.UTF8
    export ORACLE_PATH=$HOMEBREW_PREFIX/opt/instant-client/sqlplus/admin:$HOME/local/sqlplus
    export SQLPATH=$HOMEBREW_PREFIX/opt/instant-client/sqlplus/admin:$HOME/local/sqlplus
    export TNS_ADMIN=$HOMEBREW_PREFIX/etc
  fi

  # Oracle SQLcl.
  if [[ -n $(command -v sqlcl) ]]
  then
    [[ -z $TNS_ADMIN ]] && export TNS_ADMIN=$HOMEBREW_PREFIX/etc
    [[ -z $SQLPATH ]] && export SQLPATH=$HOME/local/sqlplus
  fi
fi

# Java.
export JAVA_HOME
JAVA_HOME=$(/usr/libexec/java_home)

# Append ~/local/bin to PATH.
[[ -d $HOME/local/bin ]] && export PATH=$PATH:$HOME/local/bin

# Source Bash files.
for file in $HOME/.{bash_aliases,bash_functions,bashrc.local}
do
  [[ -r $file ]] && [[ -f $file ]] && source "$file"
done

unset DEVELOPER_DIR
unset HOMEBREW_PREFIX
unset file
