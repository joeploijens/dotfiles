# ~/.bash_profile
#
# Bash startup file for login shells
#
# From the bash(1) man page:
#
#   When bash is invoked as a login shell it first reads and executes commands
#   from the file /etc/profile, if that file exists.  After reading that file,
#   it looks for ~/.bash_profile, ~/.bash_login, and ~/.profile, in that
#   order, and reads and executes commands from the first one that exists and
#   is readable.
#
#   When an interactive shell that is not a login shell is started, bash reads
#   and executes commands from ~/.bashrc, if that file exists.
#
# So, typically, ~/.bash_profile would source ~/.bashrc before or after any
# login-specific initializations.

[[ -r ~/.bashrc ]] && source ~/.bashrc
