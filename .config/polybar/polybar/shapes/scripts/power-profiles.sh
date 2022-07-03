SDIR="$HOME/.config/polybar/shapes/scripts"

MENU="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '' \
-theme $SDIR/rofi/power-profiles.rasi \
<<< "  Performance|𢡄  Balanced|  Power-Saving")"
  case "$MENU" in
    *Performance) (powerprofilesctl set performance) ;;
    *Balanced) (powerprofilesctl set balanced) ;;
    *Power-Saving) (powerprofilesctl set power-saver);;
  esac