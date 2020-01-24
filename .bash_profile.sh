# ======================================================================#
#	Author:			Leo Gothberg                                        #
#	Company:															#
#	Website:		https://www.l-gothberg.com							#
#	Description:    Bash Profile										 #
# ======================================================================#

# ======================================================================#
#	Exports																#
# ======================================================================#
export PATH=/Users/leo/bin:/usr/local/opt/sqlite/bin:/usr/local/bin:/usr/local/bin/python3:/usr/bin/ruby:/usr/bin:/bin:/usr/sbin:/sbin:/Users/leo/bin
export EDITOR='code -w'
export HOMEBREW_GITHUB_API_TOKEN='INSERT TOKEN HERE'

source ~/.alias-list.sh
source ~/.custom-functions.sh
source ~/.git-prompt.sh
source ~/.custom-prompt.sh

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
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# ======================================================================#
#	AutoJump Dependency													#
# ======================================================================#
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh