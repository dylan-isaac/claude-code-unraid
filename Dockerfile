FROM node:20-slim

LABEL maintainer="Dylan Isaac"
LABEL description="Claude Code CLI assistant container for Unraid"

# Install required dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    ripgrep \
    python3 \
    python3-pip \
    smartmontools \
    lm-sensors \
    htop \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user to run Claude Code
RUN groupadd -r claude && useradd -m -r -g claude claude

# Set working directory
WORKDIR /home/claude

# Install Claude Code CLI globally
RUN npm install -g @anthropic-ai/claude-code

# Create necessary directories
RUN mkdir -p /config /data /default_config /appdata /logs && \
    chown -R claude:claude /config /data /default_config /appdata /logs /home/claude

# Copy default CLAUDE.md to container
COPY CLAUDE.md /default_config/CLAUDE.md

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set environment variables
ENV NODE_ENV=production

# Switch to non-root user
USER claude

# Volume for persisting data and accessing user files
VOLUME ["/data", "/config", "/appdata", "/logs"]

ENTRYPOINT ["/entrypoint.sh"]