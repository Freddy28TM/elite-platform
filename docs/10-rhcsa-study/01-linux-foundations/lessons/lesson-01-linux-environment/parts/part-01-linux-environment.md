# Part 1 - Identify the Linux Environment

## 1. What the Linux Environment Means

A Linux environment is the complete operating environment in which Linux commands, programs, services, users, and system resources operate.

Before performing administration, troubleshooting, or security-related work, I need to establish the basic context of the system I am working on.

The basic environment information includes:

* The current user
* The current working directory
* The hostname
* The Linux distribution
* The distribution version
* The running kernel
* The system architecture

### Why This Matters

Linux systems can differ in their:

* Users and permissions
* Filesystem structure
* Installed software
* Running services
* Linux distributions
* Kernel versions
* Hardware architectures
* Security configurations

If I make assumptions about the system instead of identifying it first, I can run the wrong command, modify the wrong file, or misunderstand the results of an investigation.

The basic principle is:

> Identify the system first, then make changes.

### Practical Example

Before starting an administration or security task, I should be able to answer:

1. Who am I?
2. Where am I?
3. Which machine am I using?
4. Which Linux distribution is installed?
5. Which kernel is running?
6. Which architecture is being used?

The following commands will answer these questions:

```bash
whoami
pwd
hostname
cat /etc/os-release
uname -r
uname -a
uname -m
```

These commands provide the initial system context needed before moving into filesystem exploration, users and groups, processes, and security analysis.

### RHCSA Relevance

Environment identification is an important foundation for RHCSA work because RHCSA tasks are performed directly from the Linux command line.

Before performing a practical task, I need to understand the system I am operating on and interpret command output correctly.

### Security Relevance

System identification is also a basic security practice.

When investigating or administering a Linux system, I should establish the system context before making changes. This reduces the chance of investigating the wrong system, using incorrect assumptions, or modifying the wrong resources.

### Key Lesson

> Identify first. Investigate second. Change third.
## 2. The `whoami` Command

The `whoami` command displays the username of the user associated with the current shell session.

It answers the first question I should ask when working on a Linux system:

> Who am I?

### Command

```bash
whoami
```

### Command Syntax

The basic syntax is:

```text
whoami
```

`whoami` does not require an option or argument for normal use.

* `whoami` is the command.
* There is no option in this example.
* There is no argument in this example.

The command asks Linux to identify the current effective user.

### Actual Output

I ran:

```bash
whoami
```

The system returned:

```text
fredrick
```

This means the current shell is operating under the user identity `fredrick`.

### What the Output Means

The output tells me the username associated with my current effective user identity.

In this case:

```text
fredrick
```

is the normal user account I was operating as during the lesson.

This is important because Linux permissions are based heavily on user and group identities.

The identity of the current user can affect whether I can:

* Read a file
* Modify a file
* Enter a directory
* Execute a program
* Access system resources
* Use administrative privileges

### Why `whoami` Matters

Before running commands that modify the system, I should know which user I am operating as.

For example, the same command can produce different results depending on whether it is executed by:

* A normal user
* The `root` user
* Another account with different permissions

Therefore, `whoami` is a simple but useful first check.

### Security Relevance

User identity is a fundamental part of Linux security.

When investigating a system, I need to know which account is performing an action. This helps establish the permissions and privileges that the process may have.

For example, if a command is executed by `fredrick`, it should not automatically be assumed that the command has root privileges.

Later in this lesson, I will examine the difference between a normal user identity and elevated privileges using commands such as `id` and `sudo`.

### RHCSA Relevance

`whoami` is a basic Linux command that is useful during practical administration tasks.

It helps establish the current user context before performing operations involving:

* Files
* Permissions
* Groups
* Processes
* Administrative commands

Understanding the current user is therefore part of building the Linux administration knowledge required for RHCSA tasks.

### Key Lesson

> Always know which user you are operating as before making changes or interpreting permission-related results.
## 3. The `pwd` Command

The `pwd` command displays the absolute path of the current working directory.

It answers another important question when working on a Linux system:

> Where am I?

### Command

```bash
pwd
```

### Command Syntax

The basic syntax is:

```text
pwd
```

For normal use, `pwd` does not require an option or argument.

* `pwd` is the command.
* There is no option in this example.
* There is no argument in this example.

The command reports the directory in which the current shell is operating.

### Actual Output

I ran:

```bash
pwd
```

The system returned:

```text
/home/fredrick/RHCSA-Linux-Security-Lab
```

This means the current working directory during the lesson was:

```text
/home/fredrick/RHCSA-Linux-Security-Lab
```

### What the Output Means

The output is an absolute path.

An absolute path begins at the filesystem root, represented by `/`.

The path can be understood as:

```text
/
└── home
    └── fredrick
        └── RHCSA-Linux-Security-Lab
```

Each component identifies a location in the filesystem.

* `/` is the filesystem root.
* `/home` contains normal users' home directories.
* `/home/fredrick` is the home directory of the user `fredrick`.
* `/home/fredrick/RHCSA-Linux-Security-Lab` is the RHCSA learning project directory.

### Absolute and Relative Paths

An absolute path starts from the filesystem root.

Example:

```text
/home/fredrick/RHCSA-Linux-Security-Lab
```

A relative path is interpreted from the current working directory.

For example:

```text
01-linux-foundations
```

would refer to the `01-linux-foundations` directory relative to the current location if that directory exists there.

The difference matters because a relative path depends on where I currently am.

### Why `pwd` Matters

Knowing the current working directory helps prevent mistakes when working with files and directories.

Before creating, modifying, moving, or deleting something, I should know the location from which the command will operate.

For example, a command using:

```text
./file.txt
```

refers to a file relative to the current working directory.

If I do not know my current location, I may operate on the wrong file or directory.

### Security Relevance

The current working directory is important during security investigations and administration.

A relative path can refer to different resources depending on the current working directory.

Therefore, when documenting command execution, I should record the working directory when it is relevant to understanding the result.

This is especially important when investigating scripts, configuration files, logs, or commands that use relative paths.

### RHCSA Relevance

Understanding paths and the current working directory is fundamental to Linux system administration.

RHCSA tasks regularly involve:

* Navigating directories
* Managing files
* Editing configuration files
* Working with logs
* Managing permissions
* Executing scripts
* Using absolute and relative paths

`pwd` provides a quick way to verify the current location before performing these tasks.

### Verification

I can verify the current working directory at any time with:

```bash
pwd
```

I should be able to explain:

1. What directory I am currently in.
2. Whether the path is absolute or relative.
3. What each component of the path represents.

### Key Lesson

> Before working with files or directories, know where you are.

## 4. The `hostname` Command

The `hostname` command displays the name assigned to the Linux system.

It answers another important system-identification question:

> Which machine am I using?

### Command

```bash
hostname
```

### Command Syntax

The basic syntax is:

```text
hostname
```

For basic system identification, `hostname` can be used without an option or argument.

* `hostname` is the command.
* There is no option in this example.
* There is no argument in this example.

The command reads the system's configured hostname and displays it.

### Actual Output

I ran:

```bash
hostname
```

The system returned:

```text
parrot
```

This means the hostname configured for this Linux system is `parrot`.

The hostname identifies this particular Linux system or system instance within its environment.

### What the Output Means

A hostname is a name assigned to a system so that it can be identified more easily than by using only an IP address.

In this environment:

```text
parrot
```

is the hostname reported by the system.

The hostname is part of the system's identity and can be used in administration, networking, logging, and troubleshooting.

The hostname does not by itself prove the identity or trustworthiness of a system. It is simply one piece of information used to establish system context.

### Why `hostname` Matters

Knowing the hostname is useful when working with multiple Linux systems.

For example, an administrator may work with:

* A local workstation
* A development server
* A production server
* A virtual machine
* A cloud instance
* A remote system

Checking the hostname helps reduce the risk of confusing one system with another.

This is especially important when using remote administration tools such as SSH.

### Security Relevance

Hostname information can help establish context during a security investigation.

When investigating a system, I should record identifying information such as:

* Current user
* Current working directory
* Hostname
* Operating system
* Kernel
* Architecture

This creates a basic system profile before further investigation.

However, a hostname should not be treated as proof that a system is safe, trusted, or legitimate. It is an identifier, not a security guarantee.

### RHCSA Relevance

Hostname management is part of Linux system administration.

RHCSA work includes understanding system configuration and networking. Being able to identify the system's hostname is therefore an important foundational skill.

The hostname is also useful when troubleshooting network and service-related problems because it helps establish which system is being examined.

### Verification

I can verify the hostname at any time with:

```bash
hostname
```

I should be able to explain:

1. What hostname the system reports.
2. What a hostname is used for.
3. Why hostname identification matters when managing multiple systems.
4. Why hostname information alone is not a security guarantee.

### Key Lesson

> Know which system you are working on before administering or investigating it.
## 5. The `cat /etc/os-release` Command

The `cat /etc/os-release` command displays identification information about the installed Linux distribution.

It answers another important system-identification question:

> Which Linux distribution am I using?

### Command

```bash
cat /etc/os-release
```

### Command Syntax

The command is:

```text
cat /etc/os-release
```

This command contains:

* `cat` as the command
* `/etc/os-release` as the argument

The `cat` command reads and displays the contents of a file.

In this case, `/etc/os-release` is the file containing operating system identification information.

### Actual Output

I ran:

```bash
cat /etc/os-release
```

The system returned:

```text
PRETTY_NAME="Parrot Security 7.3 (echo)"
NAME="Parrot Security"
VERSION_ID="7.3"
VERSION="7.3 (echo)"
VERSION_CODENAME=echo
DEBIAN_VERSION_FULL=13.5
ID=parrot
ID_LIKE=debian
HOME_URL="https://www.parrotsec.org/"
SUPPORT_URL="https://www.parrotsec.org/docs"
BUG_REPORT_URL="https://gitlab.com/parrotsec/"
```

### What the Output Means

The output identifies the Linux distribution and provides additional information about the operating system.

The important values from this system include:

```text
PRETTY_NAME="Parrot Security 7.3 (echo)"
```

This is the human-readable name of the installed distribution.

```text
NAME="Parrot Security"
```

This identifies the distribution name.

```text
VERSION_ID="7.3"
```

This identifies the distribution version.

```text
VERSION="7.3 (echo)"
```

This provides the full distribution version information.

```text
VERSION_CODENAME=echo
```

This identifies the distribution release codename.

```text
DEBIAN_VERSION_FULL=13.5
```

This shows the full Debian version associated with the system.

```text
ID=parrot
```

This identifies the distribution using its machine-readable identifier.

```text
ID_LIKE=debian
```

This indicates that Parrot identifies itself as being related to Debian.

The file also provides project URLs for the distribution's website, documentation, and bug reporting system.

### Why `/etc/os-release` Matters

Linux is not a single distribution.

Different distributions can use different:

* Package management systems
* Default configuration locations
* System administration tools
* Service configurations
* Security defaults
* Documentation
* Release schedules

Knowing the distribution helps me choose the correct administration procedures and understand the environment in which a command is being executed.

For example, identifying this system as Parrot Security rather than assuming it is another Linux distribution prevents incorrect assumptions about the environment.

### Security Relevance

Operating system identification is important during security administration and investigation.

Before interpreting system behavior or changing configuration, I should know:

* Which distribution is installed
* Which version is running
* Which distribution family it belongs to

This information helps establish system context and can affect how packages, services, configuration files, and security controls are managed.

However, distribution identification alone does not determine whether a system is secure. It is one part of the overall system profile.

### RHCSA Relevance

RHCSA tasks are performed on Red Hat Enterprise Linux, so the exact commands and tools used in an RHCSA environment must be understood in their RHEL context.

At the same time, learning how to identify a Linux distribution is a transferable Linux administration skill.

Understanding `/etc/os-release` helps me recognize the operating environment before applying administration techniques.

It also reinforces an important administration principle:

> Do not assume the operating system environment. Identify it first.

### Verification

I can verify the distribution information at any time with:

```bash
cat /etc/os-release
```

I should be able to explain:

1. Which Linux distribution is installed.
2. Which version is installed.
3. What the distribution codename is.
4. Which distribution family the system identifies with.
5. Why distribution identification matters before performing administration tasks.

### Key Lesson

> Identify the Linux distribution and version before assuming which administration procedures or tools should be used.
## 6. The `uname -r` Command

The `uname -r` command displays the release version of the Linux kernel currently running on the system.

It answers another important system-identification question:

> Which kernel release is currently running?

### Command

```bash
uname -r
```

### Command Syntax

The command is:

```text
uname -r
```

This command contains:

* `uname` as the command
* `-r` as an option

The `uname` command provides information about the running system and kernel.

The `-r` option tells `uname` to display the kernel release.

### Actual Output

I ran:

```bash
uname -r
```

The system returned:

```text
7.0.13+parrot7-amd64
```

This is the kernel release reported by the running Linux system.

### What the Output Means

The output:

```text
7.0.13+parrot7-amd64
```

identifies the release of the Linux kernel currently running.

The kernel is the core component of the Linux operating system. It manages communication between software and hardware and provides important system functions such as:

* Process management
* Memory management
* Hardware interaction
* Device management
* Networking
* Filesystem support
* Security mechanisms

The kernel release is therefore different from the Linux distribution version.

Earlier, `/etc/os-release` reported:

```text
VERSION_ID="7.3"
```

That identifies the Parrot Security distribution version.

`uname -r` instead reports:

```text
7.0.13+parrot7-amd64
```

which identifies the running kernel release.

### Why `uname -r` Matters

Knowing the kernel release is important because kernel behavior and available features can vary between kernel versions.

When troubleshooting or administering Linux, kernel information can help explain:

* Hardware behavior
* Driver issues
* Networking behavior
* Filesystem support
* Kernel features
* Security configuration
* System compatibility

It also helps establish exactly which kernel is currently running instead of assuming that the installed distribution version tells the whole story.

### Security Relevance

Kernel identification is important during security analysis because security features and vulnerabilities can depend on the kernel version and configuration.

Knowing the running kernel allows an administrator or security analyst to establish the correct system context before researching a kernel-related issue.

However, a kernel version by itself does not prove that a system is vulnerable or secure. Additional information and verification are required.

### RHCSA Relevance

RHCSA administration requires understanding the relationship between the Linux distribution and the running kernel.

`uname -r` provides a quick way to verify the active kernel release during system administration and troubleshooting.

It is particularly useful when investigating:

* Boot problems
* Hardware problems
* Kernel-related errors
* System compatibility
* Installed and running kernel versions

### Verification

I can verify the running kernel release at any time with:

```bash
uname -r
```

I should be able to explain:

1. What `uname` does.
2. What the `-r` option means.
3. Which kernel release is currently running.
4. Why the kernel version is different from the distribution version.
5. Why kernel identification matters for administration and security.

### Key Lesson

> Know which kernel is running before diagnosing kernel-related system behavior or security issues.
## 7. The `uname -a` Command

The `uname -a` command displays all available system information provided by `uname`.

It answers a broader system-identification question:

> What information can I identify about the running Linux system and kernel at once?

### Command

```bash
uname -a
```

### Command Syntax

The command is:

```text
uname -a
```

This command contains:

* `uname` as the command
* `-a` as an option

The `-a` option tells `uname` to display all available system information.

This provides more information than `uname -r`, which displays only the kernel release.

### Actual Output

I ran:

```bash
uname -a
```

The system returned:

```text
Linux parrot 7.0.13+parrot7-amd64 #1 SMP PREEMPT_DYNAMIC Parrot 7.0.13-1parrot1 (2026-07-12) x86_64 GNU/Linux
```

### What the Output Means

The output contains several pieces of information about the running system.

```text
Linux
```

This identifies the kernel name.

```text
parrot
```

This is the hostname reported by the system.

```text
7.0.13+parrot7-amd64
```

This is the kernel release.

```text
#1 SMP PREEMPT_DYNAMIC Parrot 7.0.13-1parrot1 (2026-07-12)
```

This portion provides additional kernel build and compilation information.

It includes information such as:

* Kernel build information
* SMP support
* Preemption configuration
* Distribution-specific kernel build information
* Kernel build date

```text
x86_64
```

This identifies the system architecture.

```text
GNU/Linux
```

This identifies the operating system environment reported by `uname`.

### Comparing `uname -r` and `uname -a`

Earlier, `uname -r` returned:

```text
7.0.13+parrot7-amd64
```

That command provides the kernel release only.

`uname -a` provides a broader system summary:

```text
Linux parrot 7.0.13+parrot7-amd64 #1 SMP PREEMPT_DYNAMIC Parrot 7.0.13-1parrot1 (2026-07-12) x86_64 GNU/Linux
```

Therefore:

* `uname -r` is useful when I specifically need the kernel release.
* `uname -a` is useful when I want a broader summary of the system and kernel.

### Why `uname -a` Matters

`uname -a` is useful as a quick system-identification command.

Instead of running several `uname` options separately, I can use `uname -a` to obtain a broad overview of the kernel and system environment.

This can be useful during:

* System administration
* Troubleshooting
* Documentation
* Hardware investigation
* Compatibility checks
* Security analysis

However, `uname -a` does not replace more specific commands when detailed information is required.

For example, `/etc/os-release` provides distribution identification information that `uname -a` does not provide in the same way.

### Security Relevance

A system profile is more useful when multiple pieces of information are considered together.

For example, during an investigation I may record:

* Current user
* Current working directory
* Hostname
* Distribution
* Distribution version
* Kernel release
* Architecture

`uname -a` provides several of these system details in a single command.

This can help establish the environment before interpreting system behavior or investigating a security issue.

However, system information alone does not establish whether a system is secure or vulnerable. It provides context that must be combined with further verification.

### RHCSA Relevance

RHCSA tasks require practical understanding of the Linux system being administered.

`uname -a` provides a quick way to inspect the running kernel environment and can assist with troubleshooting and system identification.

It also reinforces the distinction between:

* Linux distribution information
* Kernel information
* Hostname
* System architecture

Understanding these differences is important when diagnosing Linux systems.

### Verification

I can verify the system and kernel information at any time with:

```bash
uname -a
```

I should be able to explain:

1. What the `uname` command does.
2. What the `-a` option means.
3. What hostname the system reports.
4. What kernel release is running.
5. What architecture the system uses.
6. How `uname -a` differs from `uname -r`.
7. Why system identification information is useful during administration and security analysis.

### Key Lesson

> Use `uname -a` when a broad summary of the running Linux system and kernel is useful.
## 8. The `uname -m` Command

The `uname -m` command displays the machine hardware name, which identifies the system architecture reported by the running kernel.

It answers another important system-identification question:

> What architecture is this Linux system using?

### Command

```bash
uname -m
```

### Command Syntax

The command is:

```text
uname -m
```

This command contains:

* `uname` as the command
* `-m` as an option

The `-m` option tells `uname` to display the machine hardware name.

### Actual Output

I ran:

```bash
uname -m
```

The system returned:

```text
x86_64
```

This means the running Linux system reports an `x86_64` machine architecture.

### What the Output Means

The value:

```text
x86_64
```

identifies the 64-bit x86 architecture used by the system.

This architecture is commonly associated with 64-bit Intel and AMD processors.

The architecture affects which compiled programs, libraries, packages, and binaries are appropriate for the system.

### Comparing the Architecture Information

The architecture also appeared in the output of `uname -a`:

```text
Linux parrot 7.0.13+parrot7-amd64 #1 SMP PREEMPT_DYNAMIC Parrot 7.0.13-1parrot1 (2026-07-12) x86_64 GNU/Linux
```

The `x86_64` value in that output agrees with the result from:

```bash
uname -m
```

This gives me another opportunity to verify that different system-identification commands provide consistent information.

### Why `uname -m` Matters

Architecture information matters because software must be compatible with the architecture on which it runs.

Knowing the architecture can help when working with:

* Software packages
* Compiled programs
* Libraries
* System binaries
* Drivers
* Virtual machines
* Hardware compatibility

For example, a package or binary built for a different architecture may not work correctly on an `x86_64` system.

### Security Relevance

Architecture is also relevant during security analysis.

When investigating software, binaries, or system behavior, knowing the system architecture helps establish the correct environment.

It can also help prevent incorrect assumptions about which binaries, libraries, or compiled components should be present.

However, architecture alone does not determine whether a system is secure or vulnerable. It is another piece of system context.

### RHCSA Relevance

Understanding system architecture is useful for Linux administration because packages, binaries, libraries, and hardware-related components must match the environment in which they are used.

`uname -m` provides a quick way to verify the architecture reported by the running kernel.

It also reinforces the distinction between:

* Linux distribution
* Distribution version
* Kernel release
* Hostname
* System architecture

These are separate pieces of information that together help identify the Linux environment.

### Verification

I can verify the machine architecture at any time with:

```bash
uname -m
```

I should be able to explain:

1. What the `uname` command does.
2. What the `-m` option means.
3. What architecture the system reports.
4. Why architecture matters for software and system compatibility.
5. Why architecture information is useful during Linux administration and security analysis.

### Key Lesson

> Know the system architecture before making assumptions about software, binaries, libraries, or hardware compatibility.
