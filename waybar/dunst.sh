#!/usr/bin/env bash

while true; do
  # Fetch history inside the loop so it updates after operations
  raw_history=$(dunstctl history)

  #  echo $raw_history
  #  echo $(echo "$raw_history" | jq '.data[0] | length')

  # Check if history is empty
  if [[ $(echo "$raw_history" | jq '.data[0] | length') -eq 0 ]]; then
    echo "Ok" | fuzzel --dmenu --lines 1 --prompt "No new notifications" --width 30
    exit 0
  fi

  # 1. Generate the list for Fuzzel
  list=$(echo "$raw_history" | jq -r '.data[0][] | "\(.summary.data): \(.body.data | gsub("\n"; " "))"')
  list=$(printf "󰑐 Reload History\n%s" "$list")

  # 2. Get the index of the selected notification
  selection_index=$(echo "$list" | fuzzel --dmenu --prompt=" History: " --index)

  echo $selection_index
  # Reload option
  [[ "$selection_index" == "0" ]] && continue

  # Exit the loop (and the script) if Escape is pressed on the main list
  [ -z "$selection_index" ] && break

  selection_index=$(($selection_index - 1))

  # 3. Extract details for the selected notification
  id=$(echo "$raw_history" | jq -r ".data[0][$selection_index].id.data")
  summary=$(echo "$raw_history" | jq -r ".data[0][$selection_index].summary.data")
  full_body=$(echo "$raw_history" | jq -r ".data[0][$selection_index].body.data")

  # 4. Action Menu
  action=$(echo -e "Pop (Redisplay)\nRemove\nClear History\nBack" |
    fuzzel --dmenu --prompt="Action for [$summary]: $full_body " --lines 4)

  case "$action" in
  "Pop (Redisplay)")
    dunstctl history-pop "$id"
    ;;
  "Remove")
    dunstctl history-rm "$id"
    ;;
  "Clear History")
    dunstctl history-clear
    ;;
  "Back" | "")
    # If "Back" is selected or Esc is pressed here, just continue the loop
    continue
    ;;
  esac

  # Signal Waybar to update the icon after every operation
  pkill -RTMIN+1 waybar
done
