# linux-user-cli

## Table of Contents

- [About](#about)
- [Features](#features)
- [Project Structure](#project-structure)
- [Requirements](#requirements)
- [Installation & Usage](#installation--usage)
- [Example](#example)
- [How It Works](#how-it-works)
- [Error Handling](#error-handling)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [Author](#author)
- [License](#license)

## About

linux-user-cli is an interactive Bash CLI to manage Linux users from a menu.  
This project is built for DevOps learning and focuses on shell scripting fundamentals, safe command execution, and defensive checks before sensitive actions.

## Features

- Interactive menu with 4 actions: create, delete, check, exit
- User creation with home directory (`useradd -m`)
- Password setup delegated to system prompt (`passwd`)
- Case-insensitive yes/no confirmations
- User existence checks before create/delete operations
- Safety guardrails for sensitive deletions

## Project Structure

```text
linux-user-cli/
├── README.md
└── user-cli.sh
```

## Requirements

- Linux distribution (Ubuntu, Debian, CentOS, Fedora, etc.)
- Bash 4.0+
- Root privileges (run with sudo or root)
- Required commands available in PATH:

    * id
    * useradd
    * userdel
    * passwd

Check Bash version:

```bash
bash --version
```

## Installation & Usage

Clone and run:

```bash
git clone https://github.com/JescAude18/linux-user-cli.git
cd linux-user-cli
chmod +x user-cli.sh
sudo ./user-cli.sh
```

Notes:
- Run with `sudo` (required by the script).
- During creation, if `passwd` is canceled (for example with Ctrl+D), the user may be created without a password.

## Example

```text
$ sudo ./user-cli.sh

-----------------------------| MENU |------------------------------
|                         1 - Create user                         |
|                         2 - Delete user                         |
|                         3 - Check user                          |
|                         4 - Exit                                |
-------------------------------------------------------------------

Choose: 3
Enter username: root
--> COMPLETED : User root exists.
```

## How It Works

1. Verifies script is executed with elevated privileges.
2. Validates required system commands before showing the menu.
3. Loops through a menu with a `case` dispatcher.
4. Executes checks using command return codes (`if id ...; then`).
5. Uses confirmation prompts before destructive actions.
6. Creates users with `useradd -m`, then calls `passwd` for password setup.

## Error Handling

- Root check blocks non-privileged execution.
- Missing command check stops early with a clear error message.
- Invalid menu value falls back to an informational prompt.
- Deletion safeguards prevent removing root or current sudo user.
- Output redirections keep validation checks silent when needed.
- Delete actions verify `userdel` return status before reporting success.

## Roadmap

- [ ] Add dry-run mode
- [ ] Add colored displaying to improve UI/UX experience

## Contributing

Contributions are welcome for learning and improvement.

1. Fork the repository.
2. Create a feature branch.
3. Commit your changes with clear messages.
4. Open a pull request with context and test steps.

## Author

- Jessica MOUSSOUGAN
- JescAude18
- DevOps learner (Linux/Bash practice projects)

## License

No license yet.

This project is currently for personal training and learning.
