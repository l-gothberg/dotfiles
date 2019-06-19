# Adds the current branch to the bash prompt when the working directory is
# part of a Git repository. Includes color-coding and indicators to quickly
# indicate the status of working directory.
#
# To use: Copy into ~/.bashrc and tweak if desired.
#
# Based upon the following gists:
# <https://gist.github.com/henrik/31631>
# <https://gist.github.com/srguiwiz/de87bf6355717f0eede5>
# Modified by me, using ideas from comments on those gists.
#
# License: MIT, unless the authors of those two gists object :)

# ======================================================================#
# Modified by Leo G., 2019 Jun 19
# Updates prompt colors for personal taste.
# ======================================================================#

reset_color="\e[/033\e[0;00m\]"
black="\e[/033\e[0;30m\]"
white="\e[/033\e[0;37m\]"
bold_white="\e[/033\e[1;37m\]"
grey="\e[/033\e[2;37m\]"
yellow="\e[/033\e[0;33m\]"
bold_yellow="\e[/033\e[1;33m\]"
brown="\e[/033\e[0;2;33m\]"
red="\e[/033\e[0;31m\]"
bold_red="\e[/033\e[1;31m\]"
dim_red="\e[/033\e[2;31m\]"
blue="\e[/033\e[0;34m\]"
bold_blue="\e[/033\e[1;34m\]"
green="\e[/033\e[0;32m\]"
bold_green="\e[/033\e[1;32m\]"
cyan="\e[/033\e[0;36m\]"
bold_cyan="\e[/033\e[1;36m\]"
purple="\e[/033\e[0;35m\]"
bold_purple="\e[/033\e[1;35m\]"
bold_underline_purple="\e[/033\e[1;4;35m\]"

git_branch() {
    # -- Finds and outputs the current branch name by parsing the list of
    #    all branches
    # -- Current branch is identified by an asterisk at the beginning
    # -- If not in a Git repository, error message goes to /dev/null and
    #    no output is produced
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

git_status() {
    # Outputs a series of indicators based on the status of the
    # working directory:
    # + changes are staged and ready to commit
    # ! unstaged changes are present
    # ? untracked files are present
    # S changes have been stashed
    # P local commits need to be pushed to the remote
    local status="$(git status --porcelain 2>/dev/null)"
    local output=''
    [[ -n $(egrep '^[MADRC]' <<<"$status") ]] && output="$output+"
    [[ -n $(egrep '^.[MD]' <<<"$status") ]] && output="$output!"
    [[ -n $(egrep '^\?\?' <<<"$status") ]] && output="$output?"
    [[ -n $(git stash list) ]] && output="${output}S"
    [[ -n $(git log --branches --not --remotes) ]] && output="${output}P"
    [[ -n $output ]] && output="|$output"  # separate from branch name
    echo $output
}

git_color() {
    # Receives output of git_status as argument; produces appropriate color
    # code based on status of working directory:
    # - White if everything is clean
    # - Green if all changes are staged
    # - Red if there are uncommitted changes with nothing staged
    # - Yellow if there are both staged and unstaged changes
    local staged=$([[ $1 =~ \+ ]] && echo yes)
    local dirty=$([[ $1 =~ [!\?] ]] && echo yes)
    if [[ -n $staged ]] && [[ -n $dirty ]]; then
        echo -e '\033[1;33m'  # bold yellow
    elif [[ -n $staged ]]; then
        echo -e '\033[1;32m'  # bold green
    elif [[ -n $dirty ]]; then
        echo -e '\033[1;31m'  # bold red
    else
        echo -e '\033[1;37m'  # bold white
    fi
}

git_prompt() {
    # First, get the branch name...
    local branch=$(git_branch)
    # Empty output? Then we're not in a Git repository, so bypass the rest
    # of the function, producing no output
    if [[ -n $branch ]]; then
        local state=$(git_status)
        local color=$(git_color $state)
        # Now output the actual code to insert the branch and status
        echo -e "\x01$color\x02[$branch$state]\x01\033[00m\x02"  # last bit resets color
    fi
}

# Prompt declaration.
# Tweak as you see fit, or just stick "$(git_prompt)" into your favorite prompt.
# See list of prompt switches below.

PS1="$bold_underline_purple\u ~ \D{%F} \A\nGit Branch$white$bold_purple:$reset_color$(git_prompt)\n$cyan\w $yellow$ $white"

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
export LSCOLORS='exfxcxdxbxegedabagacad'