#!/usr/bin/env sh

MESSAGES=(
  "DON'T PANIC"
  # "COFFEE"
  # "VIM AND CHILL"
  # "ESC :WQ"
)

msg=${MESSAGES[$((RANDOM % ${#MESSAGES[@]}))]}

printf '%b\n' "$msg" \
  | figlet -f ~/.config/figlet/fonts/ansi_shadow.flf \
  | lolcat -F 0.3 -t -p 100 -f

sleep 0.1
