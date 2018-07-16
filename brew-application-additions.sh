# youtube-dl
	# Video Title Only
	function youtube { url=$1; youtube-dl --yes-playlist -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' -o "$(pwd)/%(title)s.%(ext)s" "$url"; }
	
	# Uploader Name - Video Title
	# function youtube { url=$1; youtube-dl --yes-playlist -o "$(pwd)/%(uploader)s - %(title)s.%(ext)s" "$url"; }

	# Uploader Name - Video Title - Upload Date
	# function youtube { url=$1; youtube-dl --yes-playlist -o "$(pwd)/%(uploader)s - %(title)s.%(ext)s - %(upload_date)s" "$url"; }

# autojump
[[ -f /usr/local/etc/profile.d/autojump.sh ]] && . /usr/local/etc/profile.d/autojump.sh
[[ -s $(brew --prefix)/etc/autojump.bash ]] && . $(brew --prefix)/etc/autojump.bash