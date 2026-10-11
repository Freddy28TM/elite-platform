# Lesson 02 – Terminal and Shell

## Learning Objectives

By the end of this lesson, I should be able to:
- Explain what a terminal is.
- Explain what a shell is.
- Distinguish between a terminal and a shell.
- Explain how Bash executes commands.

## 1. What Is a Terminal?

A terminal is a program that provides an interface for interacting with a computer through text commands.

Historically, a terminal was a physical device used to communicate with a remote computer. On modern Linux systems, a terminal emulator provides the same basic interaction through a graphical application.

Examples of terminal emulators include:

- GNOME Terminal
- Konsole
- Xfce Terminal
- Tilix
- xterm

The terminal itself does not normally interpret Linux commands. Instead, it provides a text interface through which the user interacts with a shell.

### Terminal Responsibilities

A terminal emulator generally:

1. Accepts keyboard input.
2. Displays text output.
3. Provides a connection to a shell process.
4. Handles terminal-related features such as scrolling, text selection, and keyboard signals.

The distinction between a terminal and a shell is important.

A terminal provides the interface.

A shell interprets commands.

## 2. What Is a Shell?

A shell is a command interpreter that accepts commands from a user or script and causes programs or shell operations to execute.

The shell provides a way to interact with the operating system without requiring a graphical interface.

Common Unix/Linux shells include:

- Bash
- Zsh
- Fish
- Dash
- KornShell

The shell can:

- Parse commands.
- Process arguments.
- Expand variables.
- Expand wildcards.
- Connect commands with pipelines.
- Redirect input and output.
- Execute programs.
- Run shell builtins.
- Manage jobs and processes.
- Execute shell scripts.

## 3. Terminal vs Shell

A terminal and a shell are related, but they are not the same thing.

| Component | Purpose |
|---|---|
| Terminal | Provides the text-based interface |
| Shell | Interprets and executes commands |
| Program | Performs a particular task |
| Kernel | Provides the core operating-system interface to hardware and system resources |

A simplified interaction looks like this:

User
  |
  v
Terminal
  |
  v
Shell
  |
  v
Program / Shell Builtin
  |
  v
Kernel
  |
  v
Hardware / System Resources

For example, when you type:

echo hello

the terminal receives the keystrokes and passes them to the shell. The shell recognizes echo as a shell builtin on typical Bash systems and executes it. The resulting output is displayed through the terminal.

## 4. Bash

Bash stands for Bourne Again Shell.

It is one of the most widely used shells on Linux systems and is commonly used for:

- Interactive command-line work.
- System administration.
- Automation.
- Shell scripting.
- Security tooling.
- Development workflows.

The Bash executable is commonly located at:

/bin/bash

The shell used by the current session can be inspected with:

echo $SHELL

The current Bash process ID can be inspected with:

echo $$

These commands are useful because they allow us to verify what shell we are actually using instead of assuming it.


## 5. The Shell Prompt

The shell prompt is the text displayed by the shell when it is ready to receive a command.

A typical Bash prompt may look similar to:

user@host:~$

The individual parts can provide useful information:

- `user` identifies the current user.
- `host` identifies the system.
- `~` commonly represents the user's home directory.
- `$` normally indicates a regular user shell.

A root shell commonly uses `#` instead of `$`.

The exact appearance of a prompt depends on the shell configuration and environment.

The prompt is only an interface. It is not itself the shell.

## 6. Commands, Arguments, and Options

A command tells the shell what operation or program to execute.

For example:

ls

Here, `ls` is the command.

Commands can accept arguments.

For example:

ls /etc

Here:

- `ls` is the command.
- `/etc` is an argument specifying the directory to list.

Commands can also accept options that modify their behavior.

For example:

ls -l

Here:

- `ls` is the command.
- `-l` is an option requesting a long-format listing.

A command may contain a combination of the command name, options, and arguments.

For example:

ls -la /etc

The exact syntax depends on the program being executed.

When learning a command, its manual page should be treated as the authoritative reference for its supported options and arguments.

## 7. How Command Execution Works

When a command is entered into an interactive Bash shell, several stages can occur.

A simplified model is:

1. The user types a command.
2. The terminal receives the keyboard input.
3. The shell receives the input.
4. Bash parses the command.
5. Bash performs applicable expansions.
6. Bash determines whether the command is a builtin or an external program.
7. If necessary, Bash starts an external process.
8. The command executes.
9. Output and errors are returned.
10. The shell displays a new prompt.

For example:

pwd

Bash identifies `pwd` as a shell builtin on typical Bash installations and executes it within the shell process.

For an external command such as:

ls

Bash locates the executable using the command search path and starts it as an external process.

This distinction becomes important when analyzing processes, permissions, environment variables, and security behavior.

## 8. Builtins vs External Commands

Not every command typed into Bash is a separate executable file.

### Shell Builtins

A shell builtin is implemented by the shell itself.

Examples commonly include:

- cd
- echo
- pwd
- export
- unset
- alias
- history

Builtins can perform operations that need to affect the current shell process.

For example:

cd

changes the current working directory of the shell. If `cd` were executed only as a separate child process, that child process could change its own directory, but the parent shell's directory would remain unchanged.

### External Commands

An external command is normally a separate executable program stored somewhere on the filesystem.

Examples include:

- ls
- cat
- grep
- find
- ps

When Bash executes an external command, the command normally runs in a separate process.

This distinction is useful when investigating:

- Process creation.
- File permissions.
- The PATH environment variable.
- Command execution.
- Shell behavior.
- Security boundaries.


## 9. PATH

`PATH` is an environment variable containing a list of directories that Bash searches when locating external commands.

It can be displayed with:

echo $PATH

A typical PATH contains several directories separated by colons.

For example:

/usr/local/bin:/usr/bin:/bin

When a user enters an external command such as:

ls

Bash searches the directories in PATH to find an executable named `ls`.

The shell normally searches these directories in order.

This means that command lookup can depend on the current PATH configuration.

### Why PATH Matters

PATH is important for:

- Command execution.
- System administration.
- Shell scripting.
- Troubleshooting.
- Software installation.
- Security analysis.

An unexpected PATH entry can cause a different executable to be selected than the user intended.

For security work, understanding PATH helps when investigating command execution and environment configuration.

## 10. `type`, `command`, and `which`

Bash provides several tools for determining how a command is resolved.

### `type`

The `type` command can identify whether a name refers to a builtin, alias, function, keyword, or external executable.

Examples:

type cd

type echo

type ls

On a typical Bash system, `type cd` reports that `cd` is a shell builtin, while `ls` normally resolves to an executable.

### `command`

The `command` builtin can be used to execute commands while bypassing some shell lookup behavior such as aliases.

For example:

command ls

It can also be used to determine whether a command is available:

command -v ls

### `which`

`which` is commonly used to locate an external executable:

which ls

However, `which` does not provide the complete picture of Bash command resolution. Aliases, functions, and builtins can affect how Bash resolves a command name.

For Bash-specific investigation, `type` and `command -v` are generally more informative.

## 11. Interactive vs Non-Interactive Shells

A shell can operate interactively or non-interactively.

### Interactive Shell

An interactive shell accepts commands directly from a user.

For example, the Bash session opened in a terminal is normally interactive.

The user enters:

pwd

and Bash executes the command.

Interactive shells commonly provide:

- A command prompt.
- Command history.
- Interactive editing.
- Job control.
- User interaction.

### Non-Interactive Shell

A non-interactive shell executes commands without requiring a user to type each command interactively.

A common example is a shell script.

For example, a script might contain:

#!/bin/bash
echo "Hello"

Bash can execute the script without waiting for the user to manually enter each command.

Non-interactive shells are important for:

- Automation.
- Scheduled tasks.
- System administration.
- Build systems.
- Deployment workflows.
- Security automation.

The distinction matters because shell behavior can differ depending on how Bash was started and which configuration files are loaded.

## 12. Shell Processes

A shell is itself a process.

This means the Bash shell has:

- A PID.
- A parent process.
- Environment variables.
- File descriptors.
- Memory.
- Permissions.
- A current working directory.

The PID of the current Bash shell can be displayed with:

echo $$

The parent PID can be examined with:

ps -p $$ -o pid,ppid,user,comm,args

This allows us to connect the concepts from the Linux Architecture lesson with the current shell.

A shell is therefore not an abstract interface floating independently from the operating system. It is a running process managed by the kernel.

## 13. Child Processes

A process can create another process. The newly created process is commonly described as a child process.

When Bash starts an external program, that program normally executes in a separate process.

For example:

sleep 30

While `sleep` is running, another terminal can be used to inspect the process.

A useful command is:

ps --forest

The resulting process tree can show relationships between processes.

The parent-child relationship is important because process relationships affect:

- Signal handling.
- Process management.
- Permissions.
- Resource usage.
- Troubleshooting.
- Security analysis.

The exact process creation mechanism involves operating-system primitives such as `fork()` and `execve()` on traditional Unix/Linux systems. The important concept at this stage is that Bash can create a child process and arrange for that process to execute another program.

## 14. Command History

Bash normally maintains a history of commands entered during interactive sessions.

The history can be displayed with:

history

A specific number of recent commands can be viewed with:

history 10

Bash also provides history expansion and keyboard shortcuts for navigating previous commands.

Common examples include:

- Up Arrow — move backward through command history.
- Down Arrow — move forward through command history.
- Ctrl+R — search command history interactively.

Command history is useful for:

- Repeating commands.
- Troubleshooting.
- Reviewing previous work.
- Learning command-line usage.
- Reconstructing recent administrative activity.

However, command history should not automatically be treated as a complete record of everything executed on a system.

Commands can be executed in ways that do not appear in a particular interactive history, and history configuration varies between environments.

For security analysis, history is therefore one source of evidence rather than definitive proof of all activity.


## 15. Quoting Basics

Quoting controls how Bash interprets characters in a command.

The three important forms of quoting are:

- Single quotes: `'...'`
- Double quotes: `"..."`
- Backslash escaping: `\`

### Single Quotes

Single quotes preserve the literal value of almost every character inside them.

For example:

echo '$HOME'

Bash does not expand `$HOME` inside single quotes. The characters are treated literally.

### Double Quotes

Double quotes preserve most characters while still allowing certain expansions.

For example:

echo "$HOME"

Bash expands `$HOME` before executing the command.

Double quotes are particularly useful when working with variables and filenames that contain spaces.

### Backslash

A backslash can prevent Bash from interpreting the following character specially.

For example:

echo \$HOME

This prints the literal characters `$HOME` rather than expanding the variable.

Understanding quoting is essential for reliable shell commands and scripts.

Incorrect quoting can cause:

- Unexpected argument splitting.
- Incorrect variable expansion.
- Wildcard expansion.
- Commands operating on the wrong files.
- Security-sensitive command interpretation problems.

## 16. Practical Verification

The concepts in this lesson should be verified directly on a Linux system.

Run the following commands individually.

### Identify the Current User

whoami

### Identify the Shell

echo $SHELL

### Identify the Current Shell PID

echo $$

### Display the Current Working Directory

pwd

### Inspect the Shell Process

ps -p $$ -o pid,ppid,user,comm,args

### Identify Command Types

type cd
type echo
type ls

### Inspect Command Resolution

command -v ls
command -v bash

### Display PATH

echo $PATH

### Locate an External Executable

which ls

### Display Recent History

history 5

These commands connect the theoretical concepts in this lesson to the actual Linux environment.

## 17. Security Relevance

Understanding the terminal and shell is fundamental to cybersecurity.

Security professionals frequently interact with Linux systems through shells.

Knowledge of shell behavior is important for:

### Command Execution

Security analysts need to understand how commands are interpreted and executed.

### Process Analysis

Understanding parent and child processes helps analysts investigate system activity.

### Environment Analysis

Variables such as PATH can influence which programs are executed.

### Permissions

Commands execute within the security context of the current user and process.

### Automation

Bash scripts can automate repetitive administrative and security tasks.

### Incident Response

Shell history, process information, environment variables, and command execution behavior can provide useful evidence during authorized investigations.

### Secure Scripting

Quoting, input handling, command construction, and error handling are important when writing scripts that interact with the operating system.

A strong understanding of shell fundamentals therefore supports later Linux security, scripting, vulnerability research, digital forensics, and security engineering work.

## 18. Exercises

Complete these exercises on your own Linux system.

### Exercise 1 — Identify the Shell

Determine:

1. Your current username.
2. Your current shell.
3. The PID of your current shell.
4. The parent PID of your current shell.

Commands to consider:

whoami
echo $SHELL
echo $$
ps -p $$ -o pid,ppid,user,comm,args

### Exercise 2 — Investigate Commands

Use `type` to determine whether the following are Bash builtins or external commands:

cd
echo
pwd
ls
cat
grep

Record your results in your notes.

### Exercise 3 — Investigate PATH

Display your PATH:

echo $PATH

Identify each directory listed in the PATH.

Then investigate where common commands are located:

command -v ls
command -v cat
command -v grep

### Exercise 4 — Observe a Child Process

Start a temporary process:

sleep 60

While it is running, open another terminal and identify the `sleep` process.

Inspect its PID and parent PID.

After the exercise, terminate the temporary process normally.

### Exercise 5 — Quoting

Compare the results of:

echo $HOME

echo "$HOME"

echo '$HOME'

echo \$HOME

Explain why the outputs differ.

### Exercise 6 — Command History

Display your recent command history:

history 10

Identify several commands you previously executed.

Consider why shell history should not be treated as a complete record of all system activity.

## 19. Assessment

Answer the following questions without referring to the lesson initially.

### Question 1

What is a terminal?

**Answer:** A terminal is a text-based interface through which a user interacts with a computer system. It provides a place to enter commands and view their output, but it does not itself interpret the commands.

### Question 2

What is a shell?

**Answer:** A shell is a command interpreter that accepts commands from the user, interprets them, and executes them. Bash is one example of a shell.

### Question 3

What is the difference between a terminal and a shell?

**Answer:** The terminal provides the interface for interacting with the system, while the shell interprets and executes the commands entered through that interface.

### Question 4

What does Bash stand for?

**Answer:** Bash stands for **Bourne Again Shell**. It is a widely used Unix/Linux shell and is the shell used in this lesson's practical exercises.

### Question 5

What does the `$` in a typical shell prompt generally indicate?

**Answer:** In a typical Linux shell prompt, `$` generally indicates that the current shell is running as a regular user. A `#` is commonly used for a root shell.

### Question 6

What is an argument?

**Answer:** An argument is a value supplied to a command that tells the command what object, file, directory, or data it should operate on.

Example:

```bash
cat lesson-02.md
```

Here, `lesson-02.md` is an argument to `cat`.

### Question 7

What is an option?

**Answer:** An option modifies or controls how a command behaves. Options are commonly introduced with `-` or `--`.

Example:

```bash
ps -p 2909
```

Here, `-p` is an option and `2909` is its associated value.

### Question 8

What is PATH used for?

**Answer:** `PATH` is an environment variable containing a colon-separated list of directories that Bash searches when resolving external commands.

For example, when `cat` is entered, Bash can search the directories in `PATH` and locate:

```text
/usr/bin/cat
```


### Question 9

What is the difference between a shell builtin and an external command?

**Answer:** A shell builtin is implemented as part of the shell itself, while an external command is a separate executable located on the filesystem.

Examples:

```text
cd   → shell builtin
echo → shell builtin
cat  → external command
```

The exact command type can be investigated with:

```bash
type command_name
```

### Question 10

What does `$$` represent in Bash?

**Answer:** `$$` expands to the process ID (PID) of the current Bash shell.

In the practical exercise, the current shell returned:

```text
2909
```

The following command confirmed that PID `2909` belonged to the current Bash process:

```bash
ps -p $$ -o pid,ppid,user,comm,args
```

### Question 11

What is a child process?

**Answer:** A child process is a process started by another process, called its parent process.

Our practical experiment demonstrated:

```text
Bash
PID 2909
   |
   +-- sleep
       PID 7482
       PPID 2909
```

The `sleep` process was therefore a child of the Bash process.


### Question 12

What is the purpose of quoting in Bash?

**Answer:** Quoting controls how Bash interprets characters and text before executing a command.

For example:

```bash
echo $HOME
```

and:

```bash
echo "$HOME"
```

both expand `$HOME`. However:

```bash
echo '$HOME'
```

produces:

```text
$HOME
```

because single quotes prevent variable expansion. Double quotes allow variable expansion while preventing word splitting and pathname expansion. Single quotes preserve the enclosed text literally.

### Question 13

Why is shell history useful but incomplete as a source of security evidence?

**Answer:** Shell history is useful for reviewing commands entered into an interactive shell, but it is not a complete or authoritative record of system activity.

History can be incomplete because commands may be executed through scripts, services, other sessions, or other mechanisms. History can also be affected by shell configuration and user actions.

Therefore, during security analysis, shell history should be treated as **one source of evidence**, not as a complete audit log.

### Assessment Result

**Score: 13/13 — 100%**

The practical exercises and assessment were completed successfully.

### Assessment Standard

A strong result requires the learner to:

- Explain the concepts accurately.
- Demonstrate the concepts using commands.
- Interpret command output.
- Explain the security relevance.
- Troubleshoot basic shell behavior.

The target is at least 10 out of 13 questions answered correctly.

**Result: 13/13 — PASS**

If fewer than 10 are correct, review the relevant sections and repeat the practical exercises.


## 20. Completion Criteria

Lesson 02 is complete when the learner can:

- Explain what a terminal is.
- Explain what a shell is.
- Distinguish a terminal from a shell.
- Explain the role of Bash.
- Interpret a basic shell prompt.
- Distinguish commands, options, and arguments.
- Describe the basic command-execution process.
- Distinguish shell builtins from external commands.
- Explain PATH.
- Use `type` and `command -v` to investigate commands.
- Distinguish interactive and non-interactive shells.
- Explain shell processes and child processes.
- Use basic shell history features.
- Explain basic Bash quoting.
- Perform the practical verification tasks.
- Explain the security relevance of shell fundamentals.

## 21. Lesson Status

**Status: COMPLETE**

The instructional material is complete.

The lesson should be marked **COMPLETE** only after:

1. The practical verification exercises have been performed.
2. The assessment has been completed.
3. The answers have been reviewed.
4. The final file has passed documentation and Git checks.
