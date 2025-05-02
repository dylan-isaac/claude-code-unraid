#!/bin/bash
set -e

# Check if ANTHROPIC_API_KEY is set
if [ -z "${ANTHROPIC_API_KEY}" ]; then
  echo "Error: ANTHROPIC_API_KEY environment variable is not set."
  echo "Please set your Anthropic API key in the container environment variables."
  exit 1
fi

# Setup logging
LOGFILE="/logs/claude-code.log"
mkdir -p /logs

echo "$(date): Container starting up..." | tee -a $LOGFILE

# Copy custom CLAUDE.md if provided
if [ -f "/config/CLAUDE.md" ]; then
  echo "$(date): Using custom CLAUDE.md file from /config directory..." | tee -a $LOGFILE
  cp /config/CLAUDE.md /home/claude/CLAUDE.md
else
  # Use default CLAUDE.md
  echo "$(date): Using default CLAUDE.md file..." | tee -a $LOGFILE
  cp /default_config/CLAUDE.md /home/claude/CLAUDE.md
fi

# Create symlink to data directory
if [ -d "/data" ]; then
  echo "$(date): Setting up workspace in /data directory..." | tee -a $LOGFILE
  cd /data
fi

# Set up persistent appdata if needed
if [ -d "/appdata" ]; then
  echo "$(date): Setting up persistent appdata directory..." | tee -a $LOGFILE
  mkdir -p /appdata/claude-code
  # You can add additional appdata setup here
fi

# Apply any custom environment variables
if [ ! -z "$CUSTOM_NODE_OPTIONS" ]; then
  export NODE_OPTIONS=$CUSTOM_NODE_OPTIONS
  echo "$(date): Set custom NODE_OPTIONS: $CUSTOM_NODE_OPTIONS" | tee -a $LOGFILE
fi

echo "$(date): Claude Code CLI is ready to use!" | tee -a $LOGFILE
echo "Container is running. Use 'docker exec -it [container-name] claude-code' to interact with Claude Code." | tee -a $LOGFILE

# Keep container running
tail -f /dev/null