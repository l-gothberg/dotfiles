# ======================================================================#
#	Basic Commands & Functions											#
# ======================================================================#
alias reload='source ~/.bash_profile && clear && printf "Behold!  I Am Bob, the caveman who has harnessed the free exchange of electrons!\nHail, Tesla!\n\n"'

alias c=' clear; new_line=false'
alias ch=' history -c'
alias hs=' history'
alias ls='ls -oaF'
alias edit='code'
alias bp='code ~/'
alias cleartrash='rm -rf ~/.Trash/*'
alias copypath='pwd | pbcopy'
alias sqlite='sqlite3'
alias python='python3'
alias icloud="cd ~/iCloud\ Drive"
alias mono='mono --arch=32'
alias cd-subl='cd ~/Library/Application\ Support/Sublime\ Text\ 3'
alias push-subl='cd ~/Library/Application\ Support/Sublime\ Text\ 3 && git add -A && git commit -am "Perodic Automatic Backup." && git push --all'
alias clone-subl='cd ~/Library/Application\ Support/ && rm Sublime\ Text\ 3 && git clone git@github.com:l-gothberg/sublime-text-3.git && mv sublime-text-3/ Sublime\ Text\ 3/ && exit'
alias rm='rm -rfv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias cp='cp -ivpR'
alias update='brew update && brew upgrade && brew cleanup --prune=0 && softwareupdate -iaR'
function h {  history | grep "$1"; }
function mkcd { mkdir -p "$1" && cd "$1"; }			# Creates a folder and gets inside of it
function trash { command mv "$@" ~/.Trash ; }		# Moves a file to the Mac OSX trash

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
function git-push { message=$@; git add -A && git commit -m "$message" && git push --all; }