# ======================================================================#
#	Author:			Leo Gothberg											#
#	Company:															#
#	Website:															#
#	Description:	Bash Profile										#
# ======================================================================#

# ======================================================================#
#	Exports																#
# ======================================================================#
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export EDITOR='subl'

# ======================================================================#
#	Basic Commands & Functions											#
# ======================================================================#
alias c='clear; new_line=false'
alias ls='ls -oaF'
alias edit='subl'
alias bp='subl ~/.bash_profile'
alias cleartrash='rm -rf ~/.Trash/*'
alias copypath='pwd | pbcopy'
alias sqlite='sqlite3'
alias python='python3'
alias icloud="cd ~/iCloud\ Drive"
alias mono='mono --arch=32'
alias cd-subl='cd ~/Library/Application\ Support/Sublime\ Text\ 3'
alias push-subl=''
alias clone-subl=''
alias rm='rm -rfv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias cp='cp -ivpR'
function mkdircd { mkdir -p "$1" && cd "$1"; }			# Creates a folder and gets inside of it
function trash { command mv "$@" ~/.Trash ; }			# Moves a file to the Mac OSX trash
alias reload='source ~/.bash_profile && clear && printf "Behold!  I Am Bob, the caveman who has harnessed the free exchange of electrons!  Hail, Tesla!\n\n" && d=$(pwd)'

# ======================================================================#
#	OSU Server Commands											#
# ======================================================================#
alias osu='ssh gothberl@access.engr.oregonstate.edu'
alias osu-copy='scp ./* gothberl@access.engr.oregonstate.edu:~/test && ssh gothberl@access.engr.oregonstate.edu'


# ======================================================================#
#	Brew Applicaions											#
# ======================================================================#
# Uploader Name - Video Title
#function youtube { url=$1; youtube-dl --yes-playlist -o "$(pwd)/%(uploader)s - %(title)s.%(ext)s" "$url"; }

# Video Title Only
function youtube { url=$1; youtube-dl --yes-playlist -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' -o "$(pwd)/%(title)s.%(ext)s" "$url"; }


# ======================================================================#
#	Ruby Helpers											#
# ======================================================================#

alias rspec='clear && rspec'

# ======================================================================#
#	Git Commands														#
# ======================================================================#
function git-push { message=$@; git add -A && git commit -m "$message" && git push; }
alias git-run='git add -A && git commit -am'


# ======================================================================#
#	Tab Completion														#
# ======================================================================#
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

# ======================================================================#
#	Terminal Prompt Colors												#
# ======================================================================#
Black="\e[0;30m"
Blue="\e[0;34m"
Green="\e[0;32m"
Cyan="\e[0;36m"
Red="\e[0;31m"
Purple="\e[0;35m"
Brown="\e[0;33m"
Gray="\e[0;37m"
Dark_Gray="\e[1;30m"
Dark_Blue="\e[1;34m"
Dark_Green="\e[1;32m"
Dark_Cyan="\e[1;36m"
Dark_Red="\e[1;31m"
Dark_Purple="\e[1;35m"
Yellow="\e[1;33m"
White="\e[1;37m"
end="\e[0m"

# LS Color Options
# a = black			A = dark grey
# b = red			B = bold red
# c = green			C = bold green
# d = brown			D = yellow
# e = blue			E = bold blue
# f = magenta		F = magenta
# g = cyan			G = cyan
# h = grey			H = white
# x = default


export CLICOLOR=true
export CLICOLOR_FORCE=true

new_line=false

function ps_1 {
	if $new_line; then
		echo "================================================================================"
	else
		echo -n
		new_line=true
	fi
}

PROMPT_COMMAND='ps_1'
export PS1="\[$Cyan\]\u \[$Brown\]\w \$ \[$Green\]"
export LSCOLORS="excxbxdxcxexexfxdxgxdx"

# autojump dependancy
[[ -f /usr/local/etc/profile.d/autojump.sh ]] && . /usr/local/etc/profile.d/autojump.sh
[[ -s $(brew --prefix)/etc/autojump.bash ]] && . $(brew --prefix)/etc/autojump.bash

