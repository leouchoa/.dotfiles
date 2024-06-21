#!/bin/bash

# Get the name of the last used session
last_session=$(tmux list-sessions -F "#{session_name}:#{session_activity}" | sort -t: -k2,2r | head -n 1 | cut -d ":" -f 1)

# Check if a session name was found
if [ -n "$last_session" ]; then
  # Attach to the last used session
  tmux attach-session -t "$last_session"
else
  echo "No tmux sessions found."
fi
