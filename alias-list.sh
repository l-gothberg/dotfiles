# ======================================================================#
#	Basic Commands & Functions											#
# ======================================================================#
alias reload='source ~/.bash_profile && clear && printf "Behold!  I Am Bob, the caveman who has harnessed the free exchange of electrons!\nHail, Tesla!\n\n"'

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

# ======================================================================#
#	OSU Server Commands											#
# ======================================================================#
alias osu='ssh gothberl@access.engr.oregonstate.edu'
alias osu-copy='scp ./* gothberl@access.engr.oregonstate.edu:~/test && ssh gothberl@access.engr.oregonstate.edu'

# ======================================================================#
#	Ruby Helpers														#
# ======================================================================#
alias rspec='clear && rspec'

# ======================================================================#
#	Git Commands														#
# ======================================================================#
function git-push { message=$@; git add -A && git commit -m "$message" && git push; }
alias git-run='git add -A && git commit -am'