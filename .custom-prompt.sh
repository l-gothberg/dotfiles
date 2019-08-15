# ======================================================================#
# Prompt Colors													#
# ======================================================================#
reset_color="\[\e[0;00m\]"
black="\[\e[0;30m\]"
white="\[\e[0;37m\]"
bold_white="\[\e[1;37m\]"
grey="\[\e[2;37m\]"
yellow="\[\e[0;33m\]"
bold_yellow="\[\e[1;33m\]"
brown="\[\e[0;2;33m\]"
red="\[\e[0;31m\]"
bold_red="\[\e[1;31m\]"
dim_red="\[\e[2;31m\]"
blue="\[\e[0;34m\]"
bold_blue="\[\e[1;34m\]"
green="\[\e[0;32m\]"
bold_green="\[\e[1;32m\]"
dim_green="\[\e[2;32m\]"
cyan="\[\e[0;36m\]"
bold_cyan="\[\e[1;36m\]"
purple="\[\e[0;35m\]"
bold_purple="\[\e[1;35m\]"
bold_underline_purple="\[\e[1;4;35m\]"

# ======================================================================#
# Prompt Information													#
# ======================================================================#
# \a = bell character
# \d = date, in “Weekday Month Date” format (e.g., “Tue May 26”)
# \D{} = date, in strftime(3) format (NOTE: braces are required, format may be specified, blank defaults to locale settings)
# \e = escape character
# \h = hostname, up to first '.'
# \H = hostname, full
# \j = number of jobs currently managed by shell
# \l = basename of the shell’s terminal device name
# \n = newline
# \r = carriage return
# \s = name of the shell, the basename of $0 (the portion following the final slash)
# \t = time, in 24-hour HH:MM:SS format
# \T = time, in 12-hour HH:MM:SS format
# \@ = time, in 12-hour am/pm format
# \A = time, in 24-hour HH:MM format
# \u = username of the current user
# \v = version of Bash (e.g., 2.00)
# \V = release of Bash, version + patchlevel (e.g., 2.00.0)
# \w = current working directory, with $HOME abbreviated with a tilde (uses the $PROMPT_DIRTRIM variable)
# \W = basename of $PWD, with $HOME abbreviated with a tilde
# \! = history number of this command
# \# = command number of this command
# \$ = if effective uid is 0, #, otherwise $
# \nnn = character whose ASCII code is the octal value nnn
# \\ = backslash
# \[ = begins a sequence of non-printing characters (NOTE: This could be used to embed a terminal control sequence into the prompt.)
# \] = ends a sequence of non-printing characters started by \[

# PS1="$bold_underline_purple\u ~ \D{%F} \A\n$brown\w$reset_color$(__git_ps1 " (%s)") $"

GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWUNTRACKEDFILES="true"
GIT_PS1_SHOWCOLORHINTS="true"
GIT_PS1_SHOWDIRTYSTATE="true"
GIT_PS1_SHOWSTASHSTATE="true"
GIT_PS1_HIDE_IF_PWD_IGNORED="true"
GIT_PS1_STATESEPARATOR="|"

PROMPT_COMMAND='__git_ps1 "$bold_underline_purple\D{%F} \A\n\u @ \h\n$brown\w$reset_color" "\\\$ "'

# ======================================================================#
# LSCOLORS Information													#
# ======================================================================#

# The value of this variable describes what color to use for which attribute when colors are enabled with CLICOLOR.  This string is a concatenation of pairs of the format fb, where f is the foreground color and b is the background color.
# The color designators are as follows:

# a=black           A=bold black, usually shows up as dark grey
# b=red             B=bold red
# c=green           C=bold green
# d=brown           D=bold brown, usually shows up as yellow
# e=blue            E=bold blue
# f=magenta         F=bold magenta
# g=cyan            G=bold cyan
# h=light grey      H=bold light grey; looks like bright white
# x=default foreground or background

# Note that the above are standard ANSI colors.  The actual display may differ depending on the color capabilities of the terminal in use.
# The order of the attributes are as follows:

#  1.   directory
#  2.   symbolic link
#  3.   socket
#  4.   pipe
#  5.   executable
#  6.   block special
#  7.   character special
#  8.   executable with setuid bit set
#  9.   executable with setgid bit set
#  10.  directory writable to others, with sticky bit
#  11.  directory writable to others, without sticky bit

# The default is "exfxcxdxbxegedabagacad", i.e. blue foreground and default background for regular directories, black foreground and red background for setuid executables, etc.

export CLICOLOR=1
export LSCOLORS='gxfxcxdxbxegedabagacad'