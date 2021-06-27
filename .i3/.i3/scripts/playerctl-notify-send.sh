sleep 0.1

STATUS=$(playerctl status)
TITLE=$(playerctl metadata title)
ALBUM=$(playerctl metadata album)
ARTIST=$(playerctl metadata artist)

echo $1

notify-send "$STATUS $TITLE" "Album: $ALBUM \nArtist: $ARTIST"
