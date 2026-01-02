#!/usr/bin/env bash

# Count both displayed and history notifications
COUNT=$(dunstctl count history)
DISPLAYED=$(dunstctl count displayed)

# Total notifications
TOTAL=$((COUNT + DISPLAYED))

if [ "$TOTAL" -ne 0 ]; then
  # Icon: 󱅫 (Bell with badge)
  echo "{\"text\": \"󱅫\", \"class\": \"active\", \"tooltip\": \"$TOTAL notifications in history\"}"
else
  # Icon: 󰂜 (Empty bell)
  echo "{\"text\": \"󰂜\", \"class\": \"empty\", \"tooltip\": \"No notifications\"}"
fi
