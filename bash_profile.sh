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

source ~/.alias-list
source ~/.brew-application-additions
source ~/.custom-prompt
source ~/.git-branch-info


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

