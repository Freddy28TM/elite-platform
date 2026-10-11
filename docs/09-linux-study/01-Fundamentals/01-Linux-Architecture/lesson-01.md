# Lesson 01 — Linux Architecture

## Learning Objectives

By the end of this lesson, I should be able to:

- Explain what Linux is.
- Explain the role of the Linux kernel.
- Distinguish between the kernel, operating system, and Linux distribution.
- Explain kernel space and user space.
- Explain the difference between a terminal and a shell.
- Explain what Bash is.
- Understand processes and process IDs (PIDs).
- Explain the significance of PID 1.
- Understand the purpose of system calls.
- Use `/proc` to inspect running processes.
- Explain why Linux architecture matters to cybersecurity.

---

## 1. What Is Linux?

Linux is an open-source, Unix-like operating system kernel.

The **Linux kernel** is the core component responsible for managing hardware and system resources and providing controlled interfaces through which software can use those resources.

The kernel manages resources such as:

- CPU time
- Memory
- Processes
- Storage devices
- Filesystems
- Network interfaces
- Hardware devices

The term "Linux" is also commonly used to describe complete operating systems built around the Linux kernel.

---

## 2. Linux Kernel vs Operating System vs Distribution

These terms are related but are not identical.

### Linux Kernel

The kernel is the core of the system.

Its responsibilities include:

- Process management
- Memory management
- Hardware management
- Filesystem management
- Networking
- Security and access control
- Providing system calls

### Operating System

An operating system consists of the kernel together with system software and other components that allow users and applications to interact with the computer.

### Linux Distribution

A Linux distribution packages the Linux kernel together with software, libraries, package management, configuration, and other components to provide a complete operating system.

Examples include:

- Debian
- Ubuntu
- Fedora
- Arch Linux
- Parrot Security

---

## 3. Kernel Space and User Space

Linux separates privileged kernel operations from normal application operations.

### Kernel Space

Kernel space is the privileged environment where the Linux kernel operates.

The kernel can directly manage system resources and hardware.

### User Space

User space is where normal applications and processes run.

Examples include:

- Bash
- Web browsers
- Text editors
- Python programs
- Security tools
- Other command-line programs

Normal user-space applications should not directly access hardware or unrestricted kernel resources.

Instead, they request services from the kernel through controlled interfaces such as system calls.

This separation is an important security boundary.

---

## 4. Shell

A **shell** is a command interpreter that allows a user to interact with the operating system by entering commands.

Common Unix/Linux shells include:

- Bash
- Zsh
- Fish
- Dash

For example:

```bash
ls
## 5. Bash

Bash stands for Bourne Again SHell.

Bash is both:

A command-line shell
A command interpreter
A scripting environment

It can execute commands such as:
pwd
ls
whoami
uname

It can also execute shell scripts used for automation and system administration.

On the system used for this lesson, the current shell was verified with:

echo $SHELL

The result was:

/bin/bash

Therefore, the current login shell is Bash.

## 6. Terminal vs Shell

A terminal provides an interface through which a user can interact with a shell.

A shell interprets and executes commands.

A simplified relationship is:

User
  |
  v
Terminal
  |
  v
Shell
  |
  v
Command / Program
  |
  v
Kernel
  |
  v
Hardware

The terminal and shell therefore perform different roles.
## 7. Processes

A process is a running instance of a program.

Every normal Linux process has a Process ID (PID).

Linux uses PIDs to identify and manage processes.

Useful commands include:

ps

ps aux

ps -p <PID>

A process also has a parent process, identified by its Parent Process ID (PPID).

This creates a process hierarchy.

8. The Current Bash Process

Bash provides the special variable:

$$

$$ represents the PID of the current Bash shell.

This was verified on the system used for this lesson:

echo $$

Output:

2909

The process was then inspected with:

ps -p $$ -o pid,ppid,user,comm,args

Output:

PID   PPID USER     COMMAND COMMAND
2909  2887 fredrick bash    /bin/bash

This confirms that:

PID 2909 was the current Bash process.
Its parent PID was 2887.
The process belonged to user fredrick.
The process was Bash.

9. PID 1

PID 1 has special significance in a Linux system.

It is normally the first userspace process started by the Linux kernel and sits at the top of the normal process hierarchy.

It also has important responsibilities for process management and system initialization.

PID 1 was inspected with:

ps -p 1 -o pid,ppid,user,comm,args

The system returned:

PID PPID USER COMMAND  COMMAND
1   0   root systemd   /sbin/init splash noautomount splash

Therefore, on this Parrot Security system:

PID = 1
PPID = 0
User = root
Process = systemd

The system uses systemd as PID 1.

10. System Calls

Applications normally cannot directly perform privileged operations on hardware or protected kernel resources.

Instead, they request services from the kernel through system calls.

Examples of operations involving system calls include:

Opening files
Reading files
Writing files
Creating processes
Managing memory
Communicating over networks

A simplified flow is:

Application
     |
     v
System Call
     |
     v
Linux Kernel
     |
     v
Protected Resource / Hardware

System calls therefore provide an important controlled boundary between user-space applications and the kernel.

11. The /proc Filesystem

Linux provides a virtual filesystem called /proc.

It exposes information maintained by the kernel about:

Processes
System information
Kernel information
Hardware-related information
Runtime system state

Process information can be found under directories such as:

/proc/<PID>

For the current Bash process:

ls -ld /proc/$$

The result was:

dr-xr-xr-x 9 fredrick fredrick 0 Sep 4 10:58 /proc/2909

This demonstrates that /proc/2909 represents information associated with the Bash process whose PID is 2909.

12. Inspecting Process Information

The process status file can provide detailed information about a process.

The current Bash process was inspected using:

cat /proc/$$/status | head -20

Relevant output included:

Name:   bash
State:  S (sleeping)
Pid:    2909
PPid:   2887
Uid:    1000 1000 1000 1000
Gid:    1002 1002 1002 1002
Kthread:        0

This demonstrates that /proc exposes kernel-maintained information about running processes.

Important observations:

Name identifies the process.
Pid identifies the process.
PPid identifies the parent process.
Uid identifies the process owner.
Gid identifies the process group information.
Kthread: 0 indicates that this is not a kernel thread.

13. Linux Process Hierarchy

Processes form a hierarchy.

A simplified example is:

PID 1
 |
 +-- system service
 |
 +-- login/session process
       |
       +-- terminal
             |
             +-- bash
                   |
                   +-- command

The exact hierarchy varies depending on how the system and user session are configured.

Understanding process relationships is important for:

System administration
Troubleshooting
Incident response
Digital forensics
Security monitoring
Malware analysis
Understanding privilege boundaries


14. Linux System Identification

The system used for this lesson was identified with:

uname -a

Output:

Linux parrot 7.0.13+parrot7-amd64 #1 SMP PREEMPT_DYNAMIC Parrot 7.0.13-1parrot1 (2026-07-12) x86_64 GNU/Linux

The distribution information was checked with:

cat /etc/os-release

Relevant output:

PRETTY_NAME="Parrot Security 7.3 (echo)"
NAME="Parrot Security"
VERSION_ID="7.3"
VERSION="7.3 (echo)"
VERSION_CODENAME=echo
DEBIAN_VERSION_FULL=13.5
ID=parrot
ID_LIKE=debian

This confirms that the system is running:

Parrot Security 7.3 (echo)

and is based on the Debian family.

15. Current User

The current user was verified with:

whoami

Output:

fredrick

This demonstrates that commands can be executed within a specific user context.

User identity is highly important in Linux security because permissions and access to resources depend heavily on the identity and privileges of a process.

16. Why Linux Architecture Matters to Cybersecurity

Understanding Linux architecture is foundational to cybersecurity.

Processes

Security analysts need to understand:

Which processes are running
Which users own them
Which processes spawned other processes
What resources they are using
Permissions

Linux uses users, groups, ownership, and permissions to control access to resources.

Privilege Boundaries

The separation between user space and kernel space is an important security boundary.

System Calls

System calls provide a controlled interface between applications and the kernel.

Security tools can monitor system calls to identify suspicious behavior.

/proc

The /proc filesystem provides valuable runtime information for:

System administration
Troubleshooting
Security analysis
Digital forensics
Process investigation
Process Hierarchy

Understanding parent-child relationships helps analysts investigate how processes were started and how programs interact with the system.

Practical Verification

The following concepts were verified directly on a Parrot Security Linux system:

Distribution: Parrot Security 7.3 (echo)
Kernel: Linux 7.0.13+parrot7-amd64
Architecture: x86_64
Current user: fredrick
Current shell: /bin/bash
Current Bash PID: 2909
PID 1: systemd

The practical exercises verified:

Linux system identification
Current user identification
Current shell identification
Bash process identification
PID and PPID relationships
PID 1
Process information through /proc
Linux distribution information

Lesson Assessment

The following questions were used to assess understanding.

1. What is the Linux kernel?

Answer:

The Linux kernel is the core component responsible for managing hardware and system resources and providing controlled interfaces through which software can use those resources.

2. What is a Linux distribution?

Answer:

A Linux distribution packages the Linux kernel together with software, libraries, package management, configuration, and other components to provide a complete operating system.

3. What is Bash?

Answer:

Bash is a command-line shell and command interpreter used to interact with a Linux system and execute commands and scripts.

4. What does $$ represent in Bash?

Answer:

$$ represents the Process ID (PID) of the current Bash shell.

5. What is the significance of PID 1?

Answer:

PID 1 is normally the first userspace process started by the Linux kernel and sits at the top of the normal process hierarchy. On this system, PID 1 is systemd.
