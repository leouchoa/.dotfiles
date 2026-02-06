#!/bin/bash

# Check if already inside Zellij
if [ -n "$ZELLIJ" ]; then
  echo "Already inside a Zellij session."
  exit 0
fi

# Try to attach or create with default session name
# Using attach with create flag - will attach if exists, create if not
zellij attach -c main
