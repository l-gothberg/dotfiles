# ======================================================================#
# Color Information														#
# ======================================================================#
white="\e[137m\]"
gray="\e[037m\]"
black="\e[030m\]"
red="\e[031m\]"
blue="\e[034m\]"
green="\e[032m\]"
yellow="\e[133m\]"
cyan="\e[036m\]"
purple="\e[035m\]"
brown="\e[033m\]"
dark_red="\e[131m\]"
dark_blue="\e[134m\]"
dark_green="\e[132m\]"
dark_yellow="\e[133m\]"
dark_cyan="\e[136m\]"
dark_purple="\e[135m\]"
dark_brown="\e[133m\]"

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
	# di = directory
	# fi = file
	# ln = symbolic link
	# pi = fifo file
	# so = socket file
	# bd = block (buffered) special file
	# cd = character (unbuffered) special file
	# or = symbolic link pointing to a non-existent file (orphan)
	# mi = non-existent file pointed to by a symbolic link (visible when you type ls -l)
	# ex = file which is executable (ie. has 'x' set in permissions)

LSCOLORS='di=purple:fi=grey:ln=grey:pi=grey:so=grey:bd=grey:cd=grey:or=red:mi=red:ex=green'


# ======================================================================#
#	Exports																#
# ======================================================================#
export CLICOLOR=true
export CLICOLOR_FORCE=true
export PS1
export LSCOLORS