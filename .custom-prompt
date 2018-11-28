# ======================================================================#
# Color Information														#
# ======================================================================#
white="\e[137m"
gray="\e[037m"
black="\e[030m"
red="\e[031m"
blue="\e[034m"
green="\e[032m"
yellow="\e[133m"
cyan="\e[036m"
purple="\e[035m"
brown="\e[033m"
dark_red="\e[131m"
dark_blue="\e[134m"
dark_green="\e[132m"
dark_yellow="\e[133m"
dark_cyan="\e[136m"
dark_purple="\e[135m"
dark_brown="\e[133m"

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

PS1="\[$brown\]\A \[$cyan\]\u \[$brown\]\w \$ \[$green\]"

# ======================================================================#
#	LSCOLORS Information												#
# ======================================================================#
	# listing order
	# 1. directory
	# 2. file
	# 3. symbolic link
	# 4. fifo file
	# 5. socket file
	# 6. block (buffered) special file
	# 7. character (unbuffered) special file
	# 8. symbolic link pointing to a non-existent file (orphan)
	# 9. non-existent file pointed to by a symbolic link (visible when you type ls -l)
	# 10. file which is executable (ie. has 'x' set in permissions)

	# a black			# A bold black, usually shows up as dark grey
	# b red				# B bold red
	# c green			# C bold green
	# d brown			# D bold brown, usually shows up as yellow
	# e blue			# E bold blue
	# f magenta			# F bold magenta
	# g cyan			# G bold cyan
	# h light grey		# H bold light grey; looks like bright white
	# x default foreground or background

LSCOLORS='GxFxCxDxBxegedabagaced'

# ======================================================================#
#	function for more visible line break								#
# ======================================================================#
# function ps_1 {
# 	echo -n
# 	echo "================================================================================"
# }

# ======================================================================#
#	Exports																#
# ======================================================================#
export CLICOLOR=true
export CLICOLOR_FORCE=true
export PS1
export LSCOLORS