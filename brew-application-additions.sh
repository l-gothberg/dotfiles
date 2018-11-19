# youtube-dl
	# Video Title Only
	function youtube { url=$1; youtube-dl --yes-playlist -f 'best[ext=mp4]/best' -o "$(pwd)/%(title)s.%(ext)s" "$url"; }

	# Uploader Name - Video Title - Upload Date
	function youtube-detail { url=$1; youtube-dl --yes-playlist -f 'best[ext=mp4]/best' -o "$(pwd)/%(uploader)s - %(title)s.%(ext)s - %(upload_date)s" "$url"; }

	# Audio Only
	function youtube-audio { url=$1; youtube-dl -q --no-playlist -f '[ext=mp3]/worstvideo+bestaudio' -x --audio-format 'mp3' --audio-quality '0' -o "$(pwd)/%(title)s.%(ext)s" "$url"; }

# autojump
[[ -f /usr/local/etc/profile.d/autojump.sh ]] && . /usr/local/etc/profile.d/autojump.sh
[[ -s $(brew --prefix)/etc/autojump.bash ]] && . $(brew --prefix)/etc/autojump.bash