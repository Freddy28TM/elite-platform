# Part 1 — Shell Basics

## 1. What is a Shell?

The shell is the command-line interpreter that sits between you and the Linux kernel.


When you type a command, the shell:
1. Reads your input
2. Interprets the command
3. Asks the kernel to execute it
4. Displays the output

---

## 2. Check Your Shell

echo $SHELL

Expected output: /bin/bash

This tells you which shell is running.

---

## 3. Common Shells

| Shell | Path | Notes |
|-------|------|-------|
| bash | /bin/bash | Default on most Linux |
| sh | /bin/sh | Original Bourne shell |
| zsh | /bin/zsh | macOS default |
| fish | /usr/bin/fish | User-friendly |
| ksh | /bin/ksh | Korn shell |

---

## 4. Shell Prompt

The prompt tells you:
- Username
- Hostname
- Current directory
- Whether you are root (#) or user ($)

Example: `fredrick@parrot:~$`

| Symbol | Meaning |
|--------|---------|
| $ | Normal user |
| # | Root user |
| ~ | Home directory |

---

## 5. Command Structure

A command has:
- Command name
- Options (flags)
- Arguments

Example: `ls -la /home`

| Part | Value |
|------|-------|
| Command | ls |
| Option | -la |
| Argument | /home |

---

## 6. Getting Help

| Command | Purpose |
|---------|---------|
| man command | Manual page |
| command --help | Quick help |
| info command | Info pages |

Example:
man ls
ls --help

---

## 7. Key Concepts

- **Shell** = interface to kernel
- **bash** = most common shell
- **$SHELL** = variable showing your shell
- **man** = manual pages
- **--help** = quick help
- **Options** change command behavior
- **Arguments** tell command what to work on

---

## Practice

Run these commands:
1. echo $SHELL
2. man ls
3. ls --help

---

**Part 1 Complete. Next: echo Command**
