# Gitty 🚀

**Multi-Account Git CLI Tool** - Makes switching between GitHub accounts seamless

## Why Gitty?

Tired of constantly switching git configurations when working with multiple GitHub accounts? Whether you're managing personal projects and work repositories, or juggling multiple client accounts, Gitty eliminates the hassle of remembering which email and SSH key to use for each project.

## Features ✨

- **🔄 Account Switching**: Instantly switch between configured GitHub accounts
- **📝 Auto-Registration**: New accounts are registered automatically when first used
- **🔗 Smart Connections**: Connect repositories with the correct SSH configuration
- **⚡ Repository Initialization**: Initialize repos with proper branch naming
- **↩️ Uncommit Support**: Safely undo commits while keeping your changes
- **📊 Status Overview**: See current account, repository, and available accounts at a glance
- **💾 Persistent Config**: Account configurations are saved and reloaded automatically

## Installation

### Quick Install (Recommended)

```bash
# Download and install gitty
curl -fsSL https://raw.githubusercontent.com/liperama-dev/gitty/main/install.sh | bash
```

### Manual Install

1. Download the `gitty` script
2. Make it executable: `chmod +x gitty`
3. Move to PATH: `sudo mv gitty /usr/local/bin/`

## Quick Start

```bash
# 1. Initialize a new repository
gitty init

# 2. Set up your account (registers automatically if new)
gitty use mycompany

# 3. Connect to your GitHub repository
gitty connect my-awesome-project

# 4. Push your code
git push -u origin main
```

## Commands

| Command | Description |
|---------|-------------|
| `gitty init [branch]` | Initialize git repo with specified branch (default: main) |
| `gitty use <account>` | Switch to account (registers new accounts automatically) |
| `gitty connect <project>` | Connect to remote repository |
| `gitty uncommit` | Undo last commit and unstage files |
| `gitty status` | Show current repository status |
| `gitty help` | Show help message |

## Account Registration

When you use `gitty use <new_account>` for the first time, you'll be prompted for:

- **Display name** (e.g., "John Doe")
- **Email address** 
- **SSH host** (github.com or custom alias)

## SSH Setup for Multiple Accounts

For best results with multiple accounts, set up SSH host aliases in `~/.ssh/config`:

```ssh
Host github-personal
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_personal

Host github-company
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_company
```

Then register your accounts with the custom SSH hosts:

```bash
gitty use personal
# When prompted for SSH host, enter: github-personal

gitty use company  
# When prompted for SSH host, enter: github-company
```

## Examples

### Setting up a new project
```bash
mkdir my-project && cd my-project
gitty init
gitty use company
gitty connect my-project
echo "# My Project" > README.md
git add README.md
git commit -m "Initial commit"
git push -u origin main
```

### Switching between accounts
```bash
# Work on company project
cd company-project
gitty use company
git commit -m "Add new feature"
git push

# Switch to personal project
cd personal-project  
gitty use personal
git commit -m "Update documentation"
git push
```

### Undoing a commit
```bash
git commit -m "Oops, this needs more work"
gitty uncommit
# Files are now unstaged, continue editing...
```

## Workflow Benefits

**Before Gitty:**
```bash
cd project
git config user.name "John Doe"
git config user.email "john@company.com"
git remote add origin git@github-company:company/project.git
# Repeat for every repository...
```

**With Gitty:**
```bash
cd project
gitty use company
gitty connect project
# Done! 🎉
```

## Configuration

Account configurations are stored in `~/.gitty_accounts`:

```
personal=John Doe:john@personal.com:github-personal
company=John Doe:john@company.com:github-company
```

## Contributing

Found a bug or have a feature request? Please open an issue or submit a pull request!

## License

MIT License - feel free to use this in your own projects!

---

**Made with ❤️ by developers who got tired of switching git accounts manually**
