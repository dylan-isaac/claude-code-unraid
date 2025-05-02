# Claude Code for Unraid

This Docker container provides Claude Code CLI as an AI assistant tailored for Unraid server management. It helps with server maintenance, Docker management, troubleshooting, and more.

## Features

- Claude Code CLI installed and ready to use
- Customized for Unraid server management
- Built-in monitoring and maintenance tools
- Persistent configuration and logs
- Customizable CLAUDE.md file for specific server details

## Installation

### Using Community Applications (CA)

1. Navigate to the Apps tab in your Unraid webUI
2. Search for "Claude Code"
3. Click Install

### Manual Installation

1. Add the following template URL to Community Applications:
   ```
   https://raw.githubusercontent.com/dylan-isaac/claude-code-unraid/main/claude-code-unraid.xml
   ```
2. Find Claude Code in the list of available applications
3. Click Install

## Configuration

### Required Settings

- **ANTHROPIC_API_KEY**: Your Anthropic API key (required)
- **Data Directory**: Directory where Claude Code will work with your files (default: `/mnt/user`)
- **Config Directory**: Directory for Claude Code configuration (default: `/mnt/user/appdata/claude-code/config`)
- **Appdata Directory**: Directory for Claude Code persistent data (default: `/mnt/user/appdata/claude-code`)
- **Logs Directory**: Directory for Claude Code logs (default: `/mnt/user/appdata/claude-code/logs`)

### Optional Settings

- **CUSTOM_NODE_OPTIONS**: Custom Node.js options for Claude Code

## Usage

### Accessing Claude Code

You can interact with Claude Code by using docker exec:

```bash
docker exec -it claude-code-unraid claude-code
```

For a better experience, you can create a script in your user scripts plugin:

```bash
#!/bin/bash
docker exec -it claude-code-unraid claude-code "$@"
```

Save this as `claude` with execute permission to use Claude Code by simply typing `claude` in your terminal.

### Customizing CLAUDE.md

The container uses a default CLAUDE.md file that provides context for the AI assistant. You can customize this by creating your own CLAUDE.md file in the Config Directory:

1. Navigate to your Config Directory (default: `/mnt/user/appdata/claude-code/config`)
2. Create a file named `CLAUDE.md`
3. Add your custom instructions and server details

The next time the container starts, it will use your custom file instead of the default.

## Logs

Logs are stored in the Logs Directory (default: `/mnt/user/appdata/claude-code/logs`). The main log file is `claude-code.log`.

## Support

For issues and feature requests, please open an issue on the [GitHub repository](https://github.com/dylan-isaac/claude-code-unraid).

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [Anthropic](https://www.anthropic.com/) for creating Claude
- [Claude Code](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview) for the CLI tool