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
		echo "================================================================================"
}

export PS1="\[$Brown\]\A \[$Cyan\]\u \[$Brown\]\w \$ \[$Green\]"
export LSCOLORS="excxbxdxcxexexfxdxgxdx"