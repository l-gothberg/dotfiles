##### youtube-dl #####
# Video Title Only
function youtube { url=$1; youtube-dl --yes-playlist -f 'bestvideo[ext=mp4,height>=1080]+bestaudio[ext=m4a]' -o "~/Downloads/YouTube/%(title)s.%(ext)s" "$url"; }

# Uploader Name - Video Title - Upload Date
function youtube-detail { url=$1; youtube-dl --yes-playlist -f 'bestvideo[ext=mp4,height>=1080]+bestaudio[ext=m4a]' -o "~/Downloads/YouTube/%(title)s by %(uploader)s - %(upload_date)s.%(ext)s" "$url"; }

# Audio Only
function youtube-audio { url=$1; youtube-dl -q --no-playlist -f 'bestaudio[ext=mp3]' -o "~/Downloads/YouTube/%(title)s by %(uploader)s.%(ext)s" "$url"; }

##### autojump #####
[[ -f /usr/local/etc/profile.d/autojump.sh ]] && . /usr/local/etc/profile.d/autojump.sh
[[ -s $(brew --prefix)/etc/autojump.bash ]] && . $(brew --prefix)/etc/autojump.bash