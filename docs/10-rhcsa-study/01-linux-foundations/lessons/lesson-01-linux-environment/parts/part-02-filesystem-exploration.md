## Part 2 - Filesystem Exploration

### 1. `/` versus `/root`

Linux has a single filesystem hierarchy that begins at `/`.

It is important to distinguish:

```text
/       Filesystem root
/root   Home directory of the root user
```

These are completely different locations.

### `/` - Filesystem Root

`/` is the top of the Linux filesystem hierarchy.

The command:

```bash
ls -ld /
```

produced:

```text
drwxr-xr-x 18 root root 4096 Sep 15 00:22 /
```

The command:

```bash
ls -la /
```

showed the major directories and filesystem objects directly under `/`, including:

```text
boot
dev
etc
home
opt
proc
root
run
srv
sys
tmp
usr
var
```

It also showed symbolic links such as:

```text
bin -> usr/bin
lib -> usr/lib
sbin -> usr/sbin
```

The important point is that `/` is the starting point of the entire Linux filesystem hierarchy.

### `/root` - Root User's Home Directory

`/root` is the home directory belonging to the `root` user.

The command:

```bash
ls -ld /root
```

produced:

```text
drwxr-xr-x 19 root root 4096 Sep 15 20:47 /root
```

The command:

```bash
ls -la /root
```

showed files and directories belonging to the root user's environment, including:

```text
.bashrc
.cache
.config
.ssh
Desktop
Documents
Downloads
Music
Pictures
Templates
Videos
```

The ownership shown for `/root` is:

```text
root root
```

meaning:

```text
Owner: root
Group: root
```

### Important distinction

Do not confuse these two paths:

```text
/       = filesystem root
/root   = root user's home directory
```

The name `root` therefore has two related but different uses:

```text
root user       = privileged Linux account
/               = top of the filesystem hierarchy
/root           = home directory of the root user
```

### RHCSA relevance

Understanding `/` and `/root` is fundamental to navigating and administering a Linux system.

Many RHCSA tasks involve paths below `/`, including:

```text
/etc
/var
/usr
/home
/boot
```

You must also understand that `/root` is simply a directory in the filesystem hierarchy. It is not the filesystem root.

### Security relevance

The distinction is important when working with privileged accounts and sensitive files.

For example:

```text
/       contains the complete filesystem hierarchy
/root   contains the root user's personal configuration and files
```

Access to `/root` should not be confused with access to `/`.

Filesystem permissions determine who can access particular locations.

### Quick revision

```text
/       -> filesystem root
/root   -> root user's home directory
```

Remember:

> `/` is the top of the filesystem. `/root` is a directory inside it.

**Part 2, item 1 complete.**
### 2. `/home`

`/home` is the standard location for the home directories of normal users.

The command:

```bash
ls -la /home
```

produced:

```text
total 12
drwxr-xr-x  3 root     root     4096 Aug 26 16:02 .
drwxr-xr-x 18 root     root     4096 Sep 15 00:22 ..
drwx------ 38 fredrick fredrick 4096 Sep 15 20:12 fredrick
```

The command:

```bash
ls -ld /home
```

produced:

```text
drwxr-xr-x 3 root root 4096 Aug 26 16:02 /home
```

### Understanding the output

The `/home` directory is owned by:

```text
Owner: root
Group: root
Permissions: drwxr-xr-x
```

Inside `/home` is the user's home directory:

```text
/home/fredrick
```

Its ownership and permissions are:

```text
Owner: fredrick
Group: fredrick
Permissions: drwx------
```

This means the `fredrick` home directory is restricted to its owner under the permissions shown.

### Why `/home` matters

User home directories normally contain personal user files, configuration files, application data, and other files belonging to individual users.

For example:

```text
/home/fredrick
```

is the home directory for the `fredrick` account.

The home directory is also the location returned by the user's home environment when using:

```bash
cd ~
```

or:

```bash
cd /home/fredrick
```

### RHCSA relevance

Understanding `/home` is important when working with:

* Local user accounts
* User home directories
* File ownership
* Permissions
* User data
* Account configuration

RHCSA tasks involving users and permissions commonly require understanding the relationship between a user account and its home directory.

### Security relevance

Home directory permissions help protect user data from unauthorized access.

In this lab:

```text
/home/fredrick
drwx------
```

shows a restrictive permission configuration for the user's home directory.

When investigating permissions, always examine:

```text
Owner
Group
Permissions
```

rather than assuming that a directory is private simply because it is inside `/home`.

### Quick revision

```text
/home           -> standard location for normal user home directories
/home/fredrick  -> home directory of the fredrick user
```

Remember:

> `/home` contains users' home directories; the permissions on each individual home directory determine who can access its contents.
### 3. `/etc`

`/etc` contains system-wide configuration files and configuration directories.

The command:

```bash
ls -ld /etc
```

produced:

```text
drwxr-xr-x 209 root root 12288 Sep 15 20:47 /etc
```

This shows that `/etc` is:

```text
Owner: root
Group: root
Permissions: drwxr-xr-x
```

The command:

```bash
ls -la /etc | head -30
```

showed many configuration files and directories, including:

```text
NetworkManager
PackageKit
UPower
X11
adduser.conf
adjtime
alternatives
apache2
apparmor
apparmor.d
apt
bash.bashrc
```

The exact contents of `/etc` vary depending on the Linux distribution and installed software.

### Why `/etc` matters

`/etc` is one of the most important directories for Linux administration because it contains configuration used by the operating system and installed services.

Examples from the lab output include:

```text
/etc/apt
/etc/apache2
/etc/NetworkManager
/etc/apparmor
/etc/bash.bashrc
```

These demonstrate that `/etc` can contain configuration for:

* Package management
* Network management
* Web services
* Security mechanisms
* Shell behavior
* System services

### Configuration versus programs

A useful distinction is:

```text
/etc   -> configuration
/usr   -> programs and shared resources
```

A program may be installed elsewhere while its configuration is stored under `/etc`.

### RHCSA relevance

Understanding `/etc` is essential for RHCSA because many administration tasks involve system configuration.

You will encounter configuration related to:

* Users and groups
* Networking
* Services
* Authentication
* Storage and mounting
* Scheduled tasks
* Security
* System-wide application settings

The important RHCSA skill is knowing that `/etc` is a primary location to investigate when a system or service needs configuration.

### Security relevance

Configuration files can contain security-sensitive settings.

Permissions on `/etc` therefore matter. In this lab, `/etc` is owned by `root`, and ordinary users cannot normally modify its contents simply because they can read some of them.

A security investigation may involve checking:

```text
Ownership
Permissions
Configuration changes
Unexpected files
Unexpected directories
```

Do not assume every file in `/etc` is sensitive in the same way. Examine the specific file, its permissions, ownership, and purpose.

### Quick revision

```text
/etc -> system-wide configuration
```

Remember:

> When you need to understand how a Linux system or service is configured, `/etc` is one of the first places to investigate.

**Part 2, item 3 complete.**
### 4. `/usr`

`/usr` contains a large part of the installed operating system's programs, libraries, documentation, and other shared resources.

The command:

```bash id="u9u7ad"
ls -ld /usr
```

produced:

```text id="f5k4xb"
drwxr-xr-x 16 root root 4096 Jun 25 21:45 /usr
```

This shows:

```text id="8d0y9r"
Owner: root
Group: root
Permissions: drwxr-xr-x
```

The command:

```bash id="a9q9x8"
ls -la /usr
```

showed directories including:

```text id="e8m3gl"
bin
games
include
lib
lib32
lib64
libexec
local
sbin
share
src
var
```

### Important directories under `/usr`

Some of the important directories observed are:

```text id="z6g9pk"
/usr/bin
/usr/sbin
/usr/lib
/usr/lib32
/usr/lib64
/usr/include
/usr/share
/usr/local
```

Their general purposes are:

| Directory      | General purpose                            |
| -------------- | ------------------------------------------ |
| `/usr/bin`     | Common user-space programs                 |
| `/usr/sbin`    | System administration programs             |
| `/usr/lib`     | Shared libraries and program support files |
| `/usr/lib32`   | 32-bit libraries                           |
| `/usr/lib64`   | 64-bit libraries                           |
| `/usr/include` | Development header files                   |
| `/usr/share`   | Architecture-independent shared data       |
| `/usr/local`   | Locally installed software and data        |

The exact contents depend on the distribution and installed software.

### `/usr` and `/bin`, `/sbin`, `/lib`

This system uses symbolic links at the filesystem root:

```text id="b5n1gs"
/bin  -> /usr/bin
/sbin -> /usr/sbin
/lib  -> /usr/lib
```

Therefore, commands found through `/bin` or `/sbin` may actually be stored under `/usr`.

We will examine these symbolic links separately later in Part 2.

### Why `/usr` matters

When administering Linux, `/usr` is important because it contains many of the programs and libraries used by the operating system and installed applications.

For example:

```text id="y4kvh1"
/usr/bin   -> programs
/usr/sbin  -> system administration programs
/usr/lib   -> libraries and supporting files
/usr/share  -> shared data and documentation
```

### RHCSA relevance

Understanding `/usr` helps when:

* Locating installed programs
* Understanding executable paths
* Investigating libraries
* Troubleshooting applications
* Understanding system administration commands
* Working with packages

Package management tasks frequently install or update files under `/usr`.

### Security relevance

`/usr` contains many executable programs and libraries, so ownership and permissions are important.

In this lab, `/usr` is owned by:

```text id="2f5g5f"
root root
```

with:

```text id="d6c3nq"
drwxr-xr-x
```

This means ordinary users can normally read and traverse the directory but cannot modify `/usr` itself.

Unexpected modifications to system executables or libraries can therefore be important during security investigations.

### Quick revision

```text id="4x7s6p"
/usr/bin    -> common programs
/usr/sbin   -> system administration programs
/usr/lib    -> libraries
/usr/share  -> shared data
/usr/local  -> locally installed software
```

Remember:

> `/usr` contains much of the installed Linux software, libraries, and shared resources.

**Part 2, item 4 complete.**
### 5. `/var`

`/var` contains variable data: files and directories whose contents are expected to change while the system is running.

Examples include:

* System and application logs
* Package and application data
* Spool data
* Temporary data
* Web server content
* Runtime-related files

The command:

```bash
ls -ld /var
```

produced:

```text
drwxr-xr-x 12 root root 4096 Aug 26 16:03 /var
```

This shows:

```text
Owner: root
Group: root
Permissions: drwxr-xr-x
```

The command:

```bash
ls -la /var
```

showed the following directories and symbolic links:

```text
backups
cache
lib
local
lock -> /run/lock
log
mail
opt
run -> /run
spool
tmp
www
```

### Important `/var` directories

#### `/var/log`

```text
/var/log
```

contains system and application log files.

Logs are important when investigating:

* System problems
* Service failures
* Authentication activity
* Application errors
* Security events

The `/var/log` directory in this system is owned by `root:root` with:

```text
drwxr-xr-x
```

#### `/var/cache`

```text
/var/cache
```

contains cached data maintained by applications and system components.

Cached data can improve performance, but it is generally not the primary source of permanent user data.

#### `/var/lib`

```text
/var/lib
```

contains persistent application and system state.

Different services and applications can maintain their data under their own directories within `/var/lib`.

#### `/var/spool`

```text
/var/spool
```

contains queued or scheduled data used by services.

Examples can include mail queues and other service-specific spool data.

#### `/var/tmp`

```text
/var/tmp
```

is used for temporary files that may need to persist for longer than files normally placed in `/tmp`.

Your system shows:

```text
drwxrwxrwt 14 root root 4096 Sep 15 21:39 tmp
```

The final `t` is the sticky bit. This is an important permissions and security concept that will be studied in more detail later.

#### `/var/www`

```text
/var/www
```

is commonly used for web server content.

The exact contents depend on the web server and applications installed on the system.

### Symbolic links observed

Your output also showed:

```text
lock -> /run/lock
run -> /run
```

These are symbolic links.

They demonstrate that different paths in the Linux filesystem can refer to another location.

Symbolic links will be covered more systematically later when we reach:

```text
17. /bin, /lib, /sbin symlinks
```

### Why `/var` matters

Unlike directories that primarily contain static programs or configuration files, `/var` is designed for data that changes during normal system operation.

For example:

```text
/var/log  -> logs
/var/lib  -> persistent application/system state
/var/cache -> cached data
/var/spool -> queued service data
/var/tmp  -> temporary data
```

### RHCSA relevance

Understanding `/var` is important for:

* Reading system logs
* Troubleshooting services
* Managing application data
* Understanding package and service state
* Locating temporary and queued data
* Diagnosing filesystem usage

RHCSA administration tasks frequently require you to understand where system-generated data is stored.

### Security relevance

`/var` is important during security investigation because it can contain logs, application state, queues, and other changing system data.

In particular:

```text
/var/log
```

can provide evidence about system and service activity.

Permissions are also important. A directory containing logs or application state must not be assumed to be safe simply because it is under `/var`; the ownership and permissions of the specific directory or file must be checked.

### Quick revision

```text
/var
├── cache    -> cached data
├── lib      -> persistent application/system state
├── log      -> logs
├── spool    -> queued service data
├── tmp      -> temporary data
└── www      -> commonly web server content
```

Remember:

> `/var` is the main location for variable system and application data.

**Part 2, item 5 complete.**
### 6. `/tmp`

`/tmp` is the standard location for temporary files created by users, applications, and system processes.

Temporary files can include:

* Application working files
* Runtime files
* Desktop environment files
* Temporary locks
* Service-specific temporary directories
* Other short-lived data

The command:

```bash
ls -ld /tmp
```

produced:

```text
drwxrwxrwt 20 root root 460 Sep 15 21:55 /tmp
```

This shows:

```text
Owner: root
Group: root
Permissions: drwxrwxrwt
```

### Understanding the `/tmp` permissions

The permission string:

```text
drwxrwxrwt
```

can be separated into:

```text
d rwx rwx rw t
```

Meaning:

```text
d       -> directory
rwx     -> owner permissions
rwx     -> group permissions
rw      -> other users can read and write
t       -> sticky bit
```

The important security feature is the **sticky bit**.

The sticky bit on `/tmp` allows multiple users to create files in the shared directory while preventing users from freely deleting or renaming files owned by other users, subject to the normal rules for directory ownership and privileges.

This is why a shared directory such as `/tmp` can safely be writable by many users without giving every user unrestricted control over everyone else's temporary files.

### Contents observed on this system

The command:

```bash
ls -la /tmp
```

showed several types of temporary data.

For example:

```text
drwxrwxrwt  2 root     root       60 Sep 15 20:12 .ICE-unix
drwxrwxrwt  2 root     root       60 Sep 15 20:12 .X11-unix
drwxrwxrwt  2 root     root       40 Sep 15 20:02 .XIM-unix
drwxrwxrwt  2 root     root       40 Sep 15 20:02 .font-unix
drwxrwxrwt  2 root     root       40 Sep 15 20:02 VMwareDnD
```

These directories are associated with desktop, graphical-session, or virtualization-related activity.

The output also showed files belonging to the current user:

```text
-rw-rw-r-- 1 fredrick fredrick 11    Sep 15 20:12 .X0-lock
-rw-rw-r-- 1 fredrick fredrick 14572 Sep 15 21:09 part-01-before-cleanup.md
-rw-rw-r-- 1 fredrick fredrick 14572 Sep 15 21:06 part-01-current.md
```

This demonstrates that `/tmp` can contain files created by ordinary users as well as files and directories created by system services.

### Private service directories

The output also showed directories such as:

```text
systemd-private-a010da2f2c7643c5895672919a7d8a57-ModemManager.service-ZL51ox
systemd-private-a010da2f2c7643c5895672919a7d8a57-bluetooth.service-QtnZiU
systemd-private-a010da2f2c7643c5895672919a7d8a57-fwupd.service-CgGfh0
```

These directories had:

```text
drwx------
```

and were owned by:

```text
root root
```

This shows that services can have private temporary storage with restrictive permissions.

The exact contents and purpose of individual service-private directories depend on how the system's services are configured.

### Why `/tmp` matters

`/tmp` is intentionally different from ordinary system directories.

It is:

```text
shared
writable
temporary
protected by the sticky bit
```

The sticky bit is particularly important because many users and processes may need to create temporary files in the same directory.

### RHCSA relevance

Understanding `/tmp` is important for:

* Linux filesystem navigation
* Directory permissions
* Special permissions
* Temporary files
* Troubleshooting applications
* Understanding the sticky bit

The permission:

```text
drwxrwxrwt
```

is particularly important to recognize during RHCSA preparation.

### Security relevance

`/tmp` is a security-sensitive location because it is writable by many users and processes.

When investigating suspicious activity, files in `/tmp` should be examined carefully rather than automatically assumed to be malicious.

Useful observations include:

```text
Who owns the file?
What are its permissions?
When was it created or modified?
Is it executable?
What process is using it?
Where does it actually reside?
```

The sticky bit reduces the risk of users deleting or renaming other users' files in the shared directory, but it does not make `/tmp` inherently trusted.

### Quick revision

```text
/tmp
    -> temporary files and directories

drwxrwxrwt
    -> shared writable directory with sticky bit
```

Remember:

> `/tmp` is a shared temporary workspace, and the sticky bit helps prevent users from deleting or renaming other users' temporary files.

**Part 2, item 6 complete.**
### 7. `/opt`

`/opt` is commonly used for optional or additional software that is installed outside the main distribution-managed filesystem locations.

It can contain software packages, applications, or application-specific directories that are not integrated into the standard locations under `/usr`.

The command:

```bash id="8k8xv1"
ls -ld /opt
```

produced:

```text id="r2xq0n"
drwxr-xr-x 4 root root 4096 Sep 10 22:05 /opt
```

This shows:

```text id="3wz5bc"
Owner: root
Group: root
Permissions: drwxr-xr-x
```

The command:

```bash id="b3q5lz"
ls -la /opt
```

showed:

```text id="j7f0ra"
-rw-r--r--  1 root     root     69   Jan  2  2026 init.key
drwxr-xr-x  3 root     root     4096 Jun 25 21:45 microsoft
drwxr-xr-x  7 www-data www-data 4096 Jun 25 21:45 xplico
```

### Contents observed on this system

#### `/opt/microsoft`

```text id="m0e1xm"
/opt/microsoft
```

is an application-specific directory belonging to software installed on this system.

Its ownership is:

```text id="r1s8zq"
Owner: root
Group: root
Permissions: drwxr-xr-x
```

The exact software stored under an `/opt` subdirectory depends on what has been installed on the system.

#### `/opt/xplico`

```text id="d4a9kp"
/opt/xplico
```

has different ownership:

```text id="v4w6qx"
Owner: www-data
Group: www-data
Permissions: drwxr-xr-x
```

This is an important observation.

The directory is not owned by `root`, even though `/opt` itself is owned by `root:root`.

This demonstrates that ownership can differ between a parent directory and its contents.

It also shows why you should inspect the specific file or directory involved in an administration or security task rather than assuming that everything below a particular path has the same ownership.

### `/opt` is not automatically a security boundary

The fact that software is installed under `/opt` does not by itself determine whether that software is trusted, privileged, safe, or insecure.

When investigating an application under `/opt`, examine:

```text id="v3i2k4"
Ownership
Permissions
Executable files
Parent directory permissions
Configuration files
Processes using the software
```

The path alone is not enough to determine security.

### Why `/opt` matters

`/opt` provides a conventional location for optional or additional software.

A simplified view is:

```text id="8qj1ec"
/usr     -> standard installed system software and resources
/opt     -> optional or additional software
```

This is a convention rather than an absolute rule. Software can be installed in other locations depending on how it is packaged and configured.

### RHCSA relevance

Understanding `/opt` helps with:

* Filesystem navigation
* Locating installed applications
* Understanding ownership and permissions
* Troubleshooting application installations
* Identifying application-specific directories

During administration tasks, knowing the purpose of common filesystem locations makes it easier to locate files and understand their role.

### Security relevance

`/opt` can contain third-party or locally installed applications, so it can be useful during security investigations.

For example, if an unfamiliar executable is found under `/opt`, do not conclude that it is malicious solely because of its location.

Instead investigate:

```text
Who owns it?
What permissions does it have?
What package or application installed it?
Is a process using it?
What configuration does it use?
```

The `/opt/xplico` ownership observed on this system also demonstrates why ownership must be checked at the exact path being investigated.

### Quick revision

```text
/opt
    -> optional/additional software

/opt/microsoft
    -> application-specific directory

/opt/xplico
    -> application-specific directory
       owned by www-data:www-data
```

Remember:

> `/opt` is commonly used for optional or additional software, but the exact ownership and permissions of its contents must always be checked.

**Part 2, item 7 complete.**
### 8. `/dev`

`/dev` is the Linux directory containing device files and interfaces used to communicate with hardware and certain kernel-provided devices.

Linux represents many devices as files, allowing programs to interact with devices through the filesystem interface.

The command:

```bash
ls -ld /dev
```

produced:

```text
drwxr-xr-x 19 root root 3760 Sep 15 20:12 /dev
```

This shows:

```text
Owner: root
Group: root
Permissions: drwxr-xr-x
```

The command:

```bash
ls -la /dev | head -40
```

showed several different types of filesystem objects.

### Device files

One important difference in the output is the first character of the permission string.

For example:

```text
crw-r--r-- 1 root root 10, 235 Sep 15 20:02 autofs
```

The first character is:

```text
c
```

which means this is a **character device**.

Another example is:

```text
crw------- 1 root root 5, 1 Sep 15 20:02 console
```

Again, the `c` indicates a character device.

Character devices provide an interface for communicating with devices or kernel interfaces as a stream of data.

### Device permissions

Your output also demonstrates that device permissions vary.

For example:

```text
crw------- 1 root root 5, 1 Sep 15 20:02 console
```

allows access only to the owner under the displayed permission bits.

Another example:

```text
crw-rw---- 1 root video 29, 0 Sep 15 20:02 fb0
```

has:

```text
Owner: root
Group: video
Permissions: rw for owner
             rw for group
             no permissions for others
```

This demonstrates that access to device interfaces can be controlled using normal Linux ownership and permission mechanisms.

### Device numbers

Your output contains entries such as:

```text
10, 235
5, 1
29, 0
1, 7
```

These are device numbers.

For example:

```text
crw------- 1 root root 5, 1 ... console
```

contains:

```text
Major number: 5
Minor number: 1
```

The major number identifies the general device driver or device class, while the minor number identifies a particular device or instance handled by that driver.

### Directories inside `/dev`

Not everything inside `/dev` is a device file.

Your output also showed directories such as:

```text
block
bus
char
cpu
disk
dri
input
```

For example:

```text
drwxr-xr-x 2 root root 160 Sep 15 20:13 block
```

The first character is:

```text
d
```

which indicates a directory.

This is an important reminder that `/dev` contains a mixture of filesystem object types.

### Symbolic links inside `/dev`

Your output also showed symbolic links.

For example:

```text
lrwxrwxrwx 1 root root 11 Sep 15 20:02 core -> /proc/kcore
```

and:

```text
lrwxrwxrwx 1 root root 13 Sep 15 20:02 fd -> /proc/self/fd
```

and:

```text
lrwxrwxrwx 1 root root 12 Sep 15 20:02 initctl -> /run/initctl
```

The first character:

```text
l
```

means symbolic link.

This gives us an early practical example of the three filesystem object types that will be formally covered later:

```text
d -> directory
- -> regular file
l -> symbolic link
```

Device files introduce another important type:

```text
c -> character device
b -> block device
```

We will study the basic `d`, `-`, and `l` types later in the sequence, while `/dev` provides a practical example of why the first character of an `ls -l` entry matters.

### Why `/dev` matters

`/dev` provides interfaces through which programs and the operating system can interact with devices and certain kernel facilities.

Examples from this system include:

```text
/dev/console
/dev/fb0
/dev/fuse
/dev/hidraw0
/dev/hpet
/dev/i2c-0
/dev/disk
/dev/input
```

The exact devices present depend on the hardware, kernel, drivers, virtualization environment, and system configuration.

### RHCSA relevance

Understanding `/dev` is important for:

* Linux filesystem navigation
* Device management
* Storage administration
* Understanding block and character devices
* Permissions and ownership
* Troubleshooting hardware and storage
* Understanding how Linux represents devices

This becomes particularly important later when working with storage, partitions, filesystems, and mounting.

### Security relevance

Device files can provide access to hardware or kernel interfaces, so their permissions are security-sensitive.

For example:

```text
crw-rw---- 1 root video ... fb0
```

shows that membership in the `video` group can affect access to that device interface.

This is why security investigations should examine:

```text
Owner
Group
Permissions
Device type
Major/minor numbers
```

rather than treating every entry under `/dev` as an ordinary file.

### Quick revision

```text
/dev
    -> device files and device-related interfaces

c
    -> character device

b
    -> block device

d
    -> directory

l
    -> symbolic link
```

Remember:

> `/dev` exposes devices and device-related interfaces through the Linux filesystem, with permissions controlling access to many of them.

**Part 2, item 8 complete.**
### 9. `/proc`

`/proc` is a virtual filesystem that provides information about the running Linux kernel, processes, hardware, and system state.

Unlike an ordinary directory on disk, `/proc` is generated and maintained by the kernel.

The command:

```bash id="qk8z3m"
ls -ld /proc
```

produced:

```text id="5f9k1a"
dr-xr-xr-x 418 root root 0 Sep 15 20:02 /proc
```

This shows:

```text id="6x5m1p"
Owner: root
Group: root
Permissions: dr-xr-xr-x
```

Notice that the displayed size is:

```text id="1t4q8w"
0
```

This is expected for a virtual filesystem such as `/proc`. The entries are provided dynamically by the kernel rather than representing ordinary files stored on disk.

### Process directories

The command:

```bash id="f8q3ls"
ls -la /proc | head -40
```

showed directories with numeric names:

```text id="0i9q3s"
1
10
100
101
102
103
104
105
106
107
108
109
1106
111
1112
1124
1140
1190
1198
1219
1281
13
130
131
132
133
134
135
1355
137
1383
139
1395
14
140
141
```

These numeric directories represent **process IDs (PIDs)**.

For example:

```text id="c4p1s8"
/proc/1
```

represents the process with PID 1.

Similarly:

```text id="m6k2vz"
/proc/1140
```

represents the process with PID 1140.

The set of numeric directories changes as processes start and exit.

This is one of the most important relationships to remember:

```text
/proc/<PID>
```

provides information about a particular running process.

### Process ownership

Most of the process directories in the observed output were owned by:

```text id="z5g2pq"
root root
```

However, some processes were owned by other service accounts.

For example:

```text id="n4v8hc"
dr-xr-xr-x 9 ntpsec ntpsec 0 Sep 15 20:02 1190
```

and:

```text id="k7r2xd"
dr-xr-xr-x 9 rtkit rtkit 0 Sep 15 20:02 1281
```

This demonstrates that processes do not all run as `root`.

Different services can run under dedicated, less-privileged accounts.

Another example from the output was:

```text id="p3d6wa"
dr-xr-xr-x 9 root netdev 0 Sep 15 20:02 1021
```

This shows that a process can also have a group other than `root`.

### `/proc` and process investigation

`/proc` provides a direct way to investigate running processes.

For a process such as:

```text id="u7v2kd"
/proc/2318
```

we can inspect information associated with PID 2318.

This connects directly with the process investigation work from Part 4 of this lesson.

Examples of useful paths include:

```text id="y8v4mt"
/proc/<PID>/exe
/proc/<PID>/cmdline
/proc/<PID>/status
/proc/<PID>/fd
```

These provide different types of information about a running process.

For example:

```text id="w4s1pf"
/proc/<PID>/exe
```

can identify the executable associated with a process.

The `/proc/<PID>/status` file provides detailed process information.

The `/proc/<PID>/fd` directory exposes the process's open file descriptors.

### Why `/proc` matters

`/proc` is useful for observing the live state of a Linux system.

It can provide information about:

```text id="j2m8r6"
Processes
CPU information
Memory information
Kernel information
Hardware information
Process resources
Open file descriptors
System configuration
```

Some of these will be examined later in this lesson, particularly:

```text id="x5b7nq3"
/proc/cpuinfo
/proc/meminfo
```

### RHCSA relevance

Understanding `/proc` is important for:

* Process management
* System troubleshooting
* Inspecting running processes
* Understanding PIDs
* Investigating system resources
* Understanding kernel-provided information

It also provides a practical foundation for commands such as `ps`, which can be used alongside `/proc` when investigating processes.

### Security relevance

`/proc` is valuable during security investigations because it exposes information about the live system.

A useful investigation chain is:

```text id="v9k2cx"
PID
  |
  v
/proc/<PID>
  |
  +-- executable
  +-- command line
  +-- process status
  +-- open file descriptors
```

The ownership observed in your output is also significant.

For example:

```text id="s6x4hn"
1190 -> ntpsec:ntpsec
1281 -> rtkit:rtkit
```

shows that some services operate under dedicated accounts instead of `root`.

Running services with reduced privileges is an important security principle because compromising a less-privileged service does not automatically provide the same privileges as compromising a root-owned process.

### Important observation

`/proc` should not be treated like a normal persistent directory.

Its contents reflect the **current system state**.

For example:

```text id="b1c6pz"
/proc/2318
```

exists while the corresponding process exists.

If that process terminates, the corresponding `/proc/2318` directory disappears.

Similarly, new processes cause new numeric directories to appear.

### Quick revision

```text
/proc
    -> virtual kernel filesystem

/proc/<PID>
    -> information about a running process

/proc/cpuinfo
    -> CPU information

/proc/meminfo
    -> memory information
```

Remember:

> `/proc` is a kernel-provided virtual filesystem that exposes information about running processes and the current state of the Linux system.

**Part 2, item 9 complete.**
### 10. `/sys`

`/sys` is a virtual filesystem that exposes information about devices, drivers, kernel subsystems, and other aspects of the running Linux system.

It is commonly referred to as **sysfs**.

Like `/proc`, `/sys` is not primarily a normal directory tree containing ordinary files stored on disk. Its contents are provided by the kernel and reflect the current system state.

The command:

```bash id="m5p2kq"
ls -ld /sys
```

produced:

```text id="a7r4cx"
dr-xr-xr-x 13 root root 0 Sep 15 21:37 /sys
```

This shows:

```text id="d4v8nm"
Owner: root
Group: root
Permissions: dr-xr-xr-x
```

The displayed size is:

```text id="x2q7fw"
0
```

This is expected for a virtual filesystem such as `/sys`.

### Main directories observed

The command:

```bash id="w6p3za"
ls -la /sys | head -40
```

showed:

```text id="n5s8kc"
block
bus
class
dev
devices
firmware
fs
hypervisor
kernel
module
power
```

These directories organize information exposed by the kernel.

### `/sys/block`

```text id="r6h2jt"
/sys/block
```

contains information about block devices.

Block devices include storage devices such as disks and other devices that provide block-oriented storage.

This becomes particularly important later when studying:

* Disk devices
* Partitions
* Filesystems
* Mounting
* Storage administration

### `/sys/bus`

```text id="q1v8md"
/sys/bus
```

contains information organized around the Linux device bus system.

It provides information about devices and drivers associated with different buses.

### `/sys/class`

```text id="z3c6kp"
/sys/class
```

provides a higher-level view of devices grouped into device classes.

Examples of device classes can include:

```text
block
net
input
tty
```

The exact contents depend on the devices and drivers available on the system.

### `/sys/devices`

```text id="s8j4qn"
/sys/devices
```

contains the device hierarchy as represented by the kernel.

It provides information about devices and their relationships within the system.

### `/sys/firmware`

```text id="p2w6rs"
/sys/firmware
```

contains interfaces related to firmware information and firmware-provided system data when available.

### `/sys/fs`

```text id="h7k3mv"
/sys/fs
```

contains interfaces related to filesystem and kernel filesystem subsystems.

### `/sys/kernel`

```text id="c9x5la"
/sys/kernel
```

contains interfaces for various kernel-level settings and information.

### `/sys/module`

```text id="v4n8qs"
/sys/module
```

contains information about loaded kernel modules.

Kernel modules provide functionality that can be loaded into or removed from the running kernel.

This makes `/sys/module` useful when investigating which kernel modules are currently present.

### `/sys/power`

```text id="k6r1tp"
/sys/power
```

contains interfaces related to system power management.

### `/sys/hypervisor`

Your system also contains:

```text id="u8m3dw"
/sys/hypervisor
```

This is particularly interesting because the directory is present on the current system.

The exact information exposed there depends on the virtualization and kernel environment.

The presence of the directory alone does not prove a particular hypervisor is currently being used; the contents would need to be examined.

### `/sys` versus `/proc`

Both are virtual kernel filesystems, but they have different primary purposes.

```text id="w4j7cs"
/proc
    -> processes, kernel information, system state

/sys
    -> devices, drivers, kernel subsystems, hardware relationships
```

A useful mental model is:

```text id="n2p6vy"
/proc -> "What is the system and its processes doing?"

/sys  -> "How are the devices, drivers, and kernel subsystems represented?"
```

This is a simplified model, but it is useful when learning Linux administration.

### Why `/sys` matters

`/sys` provides a structured interface to information about the hardware and kernel-managed devices.

It can be useful when investigating:

```text
Devices
Drivers
Kernel modules
Storage
Network interfaces
Hardware relationships
Power management
Kernel subsystems
```

### RHCSA relevance

Understanding `/sys` helps build the foundation for:

* Device management
* Storage administration
* Hardware investigation
* Kernel module awareness
* Network interface investigation
* System troubleshooting

You will encounter these concepts more deeply when studying storage, networking, and system administration.

### Security relevance

`/sys` can expose information about the system's hardware, devices, drivers, and kernel configuration.

This information can help during system administration and security investigation.

For example, understanding loaded kernel modules can be relevant when investigating unusual system behavior.

However, the existence of a directory or module under `/sys` does not automatically indicate a security problem. The information must be interpreted in the context of the system and its configuration.

### Quick revision

```text id="y5t8kc"
/sys
    -> virtual kernel filesystem

/sys/block
    -> block devices

/sys/bus
    -> device buses

/sys/class
    -> device classes

/sys/devices
    -> device hierarchy

/sys/module
    -> loaded kernel modules

/sys/power
    -> power-management interfaces
```

Remember:

> `/sys` is a kernel-provided virtual filesystem that exposes devices, drivers, hardware relationships, and kernel subsystems.

**Part 2, item 10 complete.**
### 11. `/run`

`/run` contains runtime data for the currently running Linux system.

Unlike persistent directories such as `/etc` or `/var/lib`, `/run` is primarily concerned with data that is needed while the system is running.

It commonly contains:

* PID files
* Unix sockets
* Runtime directories
* Locks
* Service state
* Temporary runtime information

The command:

```bash id="m7q3kx"
ls -ld /run
```

produced:

```text id="q4t8vn"
drwxr-xr-x 44 root root 1120 Sep 15 20:47 /run
```

This shows:

```text id="z6p1rs"
Owner: root
Group: root
Permissions: drwxr-xr-x
```

The command:

```bash id="c5n9bw"
ls -la /run | head -40
```

showed many runtime files and directories belonging to different services.

### Runtime directories

Your output included:

```text id="x4m7qp"
NetworkManager
blkid
console-setup
credentials
cryptsetup
dbus
dnsmasq
initramfs
iodine
lightdm
lighttpd
lock
log
lvm
mount
mysqld
network
openvpn
pcscd
plymouth
podman
postgresql
runit
screen
```

These directories are created or used by system services and applications while the system is running.

The exact contents depend on the services installed and active on the system.

### PID files

Your output included files such as:

```text id="v9c2mk"
crond.pid
lightdm.pid
nginx.pid
ntpd.pid
```

A PID file commonly stores the process ID of a running service.

For example:

```text id="a6w3rp"
/run/nginx.pid
```

can be used by software or administration tools to identify the PID associated with the Nginx service.

PID files are one reason `/run` is useful when managing running services.

### Unix sockets and special files

The output also contained:

```text id="h2k8sv"
docker.sock -> /run/podman/podman.sock
```

This is a symbolic link pointing to a Unix socket used by Podman.

The output also showed entries beginning with:

```text id="j8v4cx"
p
```

For example:

```text id="r3m9xd"
prw------- 1 root root 0 Sep 15 20:02 dmeventd-client
prw------- 1 root root 0 Sep 15 20:02 dmeventd-server
```

The `p` indicates a **named pipe (FIFO)**.

This is another example of how Linux uses the filesystem interface for communication between processes.

### Locks

Your output showed:

```text id="k7p2vx"
drwxrwxrwt 4 root root 180 Sep 15 20:47 lock
```

`/run/lock` is used for runtime lock files and related coordination between processes and services.

Notice that `/var/lock` from the earlier `/var` inspection was a symbolic link to:

```text id="b5m1zc"
/run/lock
```

So the two paths ultimately refer to the same runtime location.

### Service-specific ownership

Not everything under `/run` is owned by `root`.

Your output included:

```text id="s6v4qm"
drwxr-xr-x 2 dnsmasq nogroup 40 Sep 15 20:02 dnsmasq
drwxr-x--- 2 www-data www-data 40 Sep 15 20:02 lighttpd
drwxr-xr-x 2 mysql mysql 40 Sep 15 20:02 mysqld
drwxrwsr-x 2 postgres postgres 40 Sep 15 20:02 postgresql
```

This demonstrates an important Linux security principle.

Services can maintain their runtime data using dedicated service accounts rather than operating everything as `root`.

For example:

```text id="p2r8wy"
mysql      -> mysql:mysql
postgresql -> postgres:postgres
lighttpd   -> www-data:www-data
dnsmasq    -> dnsmasq:nogroup
```

The exact ownership and permissions determine who can access the runtime information.

### Why `/run` matters

`/run` represents the state of the system while it is running.

A useful simplified distinction is:

```text id="q6n4vz"
/etc       -> configuration
/var/lib   -> persistent application/system state
/run       -> current runtime state
```

For example:

```text id="z3w7kc"
/run/nginx.pid
```

is runtime information about a running service, while configuration for that service would normally be stored elsewhere.

### `/run` and system startup

`/run` is normally created and populated during system startup.

Because its contents represent runtime state, much of the information found there is not intended to be permanent system data.

This means `/run` should not be treated like a normal persistent data directory.

### RHCSA relevance

Understanding `/run` helps with:

* Service management
* Process identification
* PID files
* Runtime sockets
* Locks
* Troubleshooting services
* Understanding system startup and runtime state

When troubleshooting a service, `/run` can provide useful evidence about whether and how that service is currently running.

### Security relevance

`/run` can contain sensitive runtime information and communication interfaces.

For example:

```text id="y5j8vr"
/run/*.pid
/run/*.sock
/run/*/
```

may provide information about active services and processes.

Permissions therefore matter.

A security investigation should examine:

```text id="n1x6qc"
Owner
Group
Permissions
File type
Service using the file
```

Do not assume that every runtime file should be accessible to every user.

### Quick revision

```text id="m9q2hf"
/run
    -> current runtime data

PID files
    -> identify running service processes

Sockets
    -> process/service communication

Locks
    -> runtime coordination

Service directories
    -> service-specific runtime state
```

Remember:

> `/run` contains runtime data needed by the currently running system, including PID files, sockets, locks, and service state.

**Part 2, item 11 complete.**
### 12. `/boot`

`/boot` contains files required during the Linux boot process.

It commonly contains:

* Linux kernel images
* Initial RAM filesystem images
* Kernel configuration information
* System map files
* Bootloader files
* EFI-related files

The command:

```bash id="q6p1vz"
ls -ld /boot
```

produced:

```text id="b8r4xm"
drwxr-xr-x 4 root root 4096 Sep 15 20:47 /boot
```

This shows:

```text id="w3k7cn"
Owner: root
Group: root
Permissions: drwxr-xr-x
```

The command:

```bash id="c9v2hs"
ls -la /boot
```

showed files for two kernel versions:

```text id="a5m8rd"
7.0.13+parrot7-amd64
7.0.9+parrot7-amd64
```

This demonstrates that more than one kernel version can be stored on a Linux system.

### Kernel images

Your output contained:

```text id="j4r7kp"
-rw-r--r-- 1 root root 14029312 Jul 12 14:36 vmlinuz-7.0.13+parrot7-amd64
-rw-r--r-- 1 root root 14017024 May 28 19:32 vmlinuz-7.0.9+parrot7-amd64
```

The `vmlinuz-*` files are Linux kernel images.

Your currently running kernel from Part 1 was:

```text id="s8w2nf"
7.0.13+parrot7-amd64
```

Therefore, the corresponding kernel image is present in `/boot`:

```text id="n2c6vg"
/boot/vmlinuz-7.0.13+parrot7-amd64
```

### Initial RAM filesystem

Your output also showed:

```text id="k7x3pm"
-rw------- 1 root root 236295796 Sep 15 20:47 initrd.img-7.0.13+parrot7-amd64
-rw------- 1 root root 235757439 Aug 26 16:02 initrd.img-7.0.9+parrot7-amd64
```

These are initial RAM filesystem images.

They provide files and drivers needed during the early stages of boot before the normal root filesystem is fully available.

The restrictive permissions:

```text id="q8v1zs"
-rw-------
```

mean that the files are readable and writable only by their owner under the displayed permission bits.

The owner is:

```text id="r5m3cx"
root
```

### Kernel configuration files

The output included:

```text id="w6h2pt"
config-7.0.13+parrot7-amd64
config-7.0.9+parrot7-amd64
```

These files contain configuration information associated with the corresponding kernel builds.

For example:

```text id="g4n8sv"
/boot/config-7.0.13+parrot7-amd64
```

corresponds to:

```text id="y3c6mq"
/boot/vmlinuz-7.0.13+parrot7-amd64
```

### System.map files

The output also showed:

```text id="p6k2wr"
System.map-7.0.13+parrot7-amd64
System.map-7.0.9+parrot7-amd64
```

`System.map` files contain symbol information associated with a particular kernel build.

They can be useful for debugging and understanding kernel symbols.

### GRUB

Your `/boot` directory contains:

```text id="e5m9qc"
grub
grub-16x9.png
grub-4x3.png
grub_background.sh
```

The `grub` directory contains files used by the GRUB bootloader.

GRUB is responsible for presenting boot choices and loading the selected operating system kernel.

The graphical files and script shown in the output are related to the GRUB boot environment on this system.

### EFI

Your output also showed:

```text id="v7q2mx"
drwxr-xr-x 4 root root 1024 Jan 1 1970 efi
```

The:

```text
/boot/efi
```

directory is associated with UEFI booting.

The exact files beneath it depend on the system's UEFI configuration.

### Multiple kernel versions

This system currently has:

```text id="c8v5lz"
7.0.13+parrot7-amd64
7.0.9+parrot7-amd64
```

This is useful because older kernels can remain installed alongside a newer kernel.

If a newly installed kernel has a problem, having another installed kernel can provide an alternative boot option.

### Why `/boot` matters

The boot process depends on several components working together.

A simplified sequence is:

```text id="n4q7sx"
Firmware
   |
   v
Bootloader
   |
   v
Linux kernel
   |
   v
Initial RAM filesystem
   |
   v
Normal userspace
```

`/boot` contains important files used during this process.

### RHCSA relevance

Understanding `/boot` is important for:

* Kernel management
* Boot troubleshooting
* GRUB
* Boot targets
* System startup
* Kernel versions
* Understanding the Linux boot process

The RHCSA exam includes objectives related to controlling the boot process and working with system startup.

### Security relevance

`/boot` is security-sensitive because it contains components involved in starting the operating system.

Important files include:

```text id="u8j3pv"
/boot/vmlinuz-*
/boot/initrd.img-*
/boot/grub/
/boot/efi/
```

Unauthorized modification of boot components could affect system integrity.

The ownership and permissions observed on this system show that these files are primarily controlled by `root`.

### Quick revision

```text id="s7k2qd"
/boot
    -> boot-related files

vmlinuz-*
    -> Linux kernel

initrd.img-*
    -> initial RAM filesystem

config-*
    -> kernel configuration

System.map-*
    -> kernel symbol information

grub/
    -> GRUB bootloader files

efi/
    -> UEFI-related boot files
```

Remember:

> `/boot` contains the kernel, initial RAM filesystem, bootloader data, and other files required during system startup.

**Part 2, item 12 complete.**
### 13. `/media`

`/media` is a standard directory used as a mount point for removable media.

It is commonly associated with automatically mounted devices such as:

* USB flash drives
* External storage
* CDs or DVDs
* Other removable media

Modern Linux systems often create subdirectories beneath `/media` when removable devices are mounted.

The command:

```bash
ls -ld /media
```

produced:

```text
drwxr-xr-x 2 root root 4096 Jun 15 12:15 /media
```

This shows:

```text
Owner: root
Group: root
Permissions: drwxr-xr-x
```

The directory itself is therefore controlled by `root`.

### Current contents

The command:

```bash
ls -la /media
```

produced:

```text
total 8
drwxr-xr-x 2 root root 4096 Jun 15 12:15 .
drwxr-xr-x 18 root root 4096 Sep 15 00:22 ..
```

There are no additional entries currently inside `/media`.

The two entries shown are:

```text
.    -> current directory
..   -> parent directory
```

Therefore, there is currently no removable media mounted under `/media`.

### Mount point concept

A mount point is a directory where another filesystem becomes accessible.

For example, a removable device might appear as:

```text
/media/usb
```

after it has been mounted.

The exact directory name and mounting behavior depend on the Linux system and its desktop or automount configuration.

### Why `/media` matters

`/media` provides a conventional location for removable filesystems.

Understanding mount points is important because Linux does not treat mounted storage as a separate drive letter system like Windows. Instead, filesystems are attached to directories within the existing filesystem hierarchy.

### RHCSA relevance

Understanding `/media` helps with:

* Filesystem navigation
* Mount points
* Removable storage
* Filesystem administration
* Diagnosing mounted filesystems

This becomes particularly important when learning commands such as:

```bash
mount
findmnt
lsblk
df
```

### Security relevance

Removable media can introduce security considerations because external storage may contain untrusted files.

When investigating a Linux system, it is useful to know:

```text
/media
    -> conventional location associated with removable media
```

The permissions observed on this system are:

```text
drwxr-xr-x root root /media
```

The directory itself is therefore not writable by ordinary users based on its displayed permission bits.

### Quick revision

```text
/media
    -> conventional mount location for removable media

Current state
    -> directory exists
    -> owned by root:root
    -> currently contains no mounted-media subdirectory
```

Remember:

> `/media` is a conventional location used for removable filesystems and their mount points.

**Part 2, item 13 complete.**
### 14. `/mnt`

`/mnt` is a standard directory traditionally used as a temporary mount point for filesystems.

Administrators can use `/mnt` when they need to manually mount a filesystem for tasks such as:

* Maintenance
* Troubleshooting
* Filesystem inspection
* Temporary access to storage

Unlike `/media`, which is commonly associated with removable media and desktop automounting, `/mnt` is traditionally intended for administrator-controlled temporary mounts.

The command:

```bash
ls -ld /mnt
```

produced:

```text
drwxr-xr-x 2 root root 4096 Jun 15 12:15 /mnt
```

This shows:

```text
Owner: root
Group: root
Permissions: drwxr-xr-x
```

### Current contents

The command:

```bash
ls -la /mnt
```

produced:

```text
total 8
drwxr-xr-x  2 root root 4096 Jun 15 12:15 .
drwxr-xr-x 18 root root 4096 Sep 15 00:22 ..
```

There are currently no additional entries inside `/mnt`.

The entries:

```text
.
..
```

represent:

```text
.   -> current directory
..  -> parent directory
```

Therefore, no filesystem or other directory is currently visible beneath `/mnt`.

### `/mnt` as a mount point

A filesystem can be attached to `/mnt` with a mount operation.

For example, the general syntax is:

```bash
mount <device> /mnt
```

This means that the filesystem provided by `<device>` becomes accessible through `/mnt`.

The mount operation itself requires appropriate privileges.

The important concept is:

```text
Before mounting:
    /mnt -> ordinary directory

After mounting a filesystem:
    /mnt -> access point to the mounted filesystem
```

### `/mnt` versus `/media`

The two directories have different traditional purposes:

```text
/media
    -> commonly associated with automatically mounted removable media

/mnt
    -> commonly used for temporary administrator-controlled mounts
```

The exact behavior can vary between Linux distributions and system configurations.

### RHCSA relevance

Understanding `/mnt` is important for filesystem administration.

RHCSA tasks can involve:

* Mounting filesystems
* Identifying devices
* Working with mount points
* Checking mounted filesystems
* Making mounts persistent

Commands that become important later include:

```bash
mount
findmnt
lsblk
df
```

### Security relevance

Mount points are important during security and system investigations.

A mounted filesystem can provide access to additional files and data that are not part of the currently examined filesystem location.

Administrators should therefore understand:

```text
device
   |
   v
filesystem
   |
   v
mount point
   |
   v
accessible files
```

The current `/mnt` permissions are:

```text
drwxr-xr-x root root
```

so the directory itself is owned by `root` and is not writable by ordinary users based on the displayed permission bits.

### Quick revision

```text
/mnt
    -> conventional temporary mount point
    -> commonly used for administrator-controlled mounts
    -> currently empty on this system
    -> owned by root:root
    -> permissions: drwxr-xr-x
```

Remember:

> `/mnt` is a conventional mount point commonly used for temporary, manually managed filesystem mounts.

**Part 2, item 14 complete.**

### 15. `/srv`

`/srv` is a standard Linux directory intended to contain data served by system services.

The name `srv` is short for **service**.

Examples of data that may be stored under `/srv` include:

* Website files served by a web server
* Files provided by an FTP service
* Data made available through other network services

The exact directory structure depends on the services installed and how the system is configured.

### Directory permissions and ownership

The command:

```bash
ls -ld /srv
```

produced:

```text
drwxr-xr-x 2 root root 4096 Jun 15 12:15 /srv
```

This shows:

```text
Owner: root
Group: root
Permissions: drwxr-xr-x
```

The directory is therefore owned by `root:root`.

### Current contents

The command:

```bash
ls -la /srv
```

produced:

```text
total 8
drwxr-xr-x 2 root root 4096 Jun 15 12:15 .
drwxr-xr-x 18 root root 4096 Sep 15 00:22 ..
```

There are currently no additional entries inside `/srv`.

The entries represent:

```text
.   -> current directory
..  -> parent directory
```

### Why `/srv` matters

`/srv` provides a conventional location for data made available by services.

For example, a system administrator might organize service data as follows:

```text
/srv
└── example-service
    └── data
```

This is an illustrative structure. The actual location used by a service depends on its configuration.

### RHCSA relevance

Understanding `/srv` helps with:

* Filesystem hierarchy
* Service-related file locations
* Directory navigation
* File ownership and permissions
* System administration

It is also useful when investigating where a service stores or publishes data.

### Security relevance

Service data may be accessible to other users or remote clients, depending on service configuration and permissions.

When examining `/srv`, check:

* Directory ownership
* Directory permissions
* Files stored inside
* Which service uses the data
* Whether the data is intended to be publicly accessible

The current permissions show that `/srv` is owned by `root:root` and is not writable by ordinary users based on its displayed permission bits.

### Quick revision

```text
/srv
    -> conventional location for service-provided data
    -> owned by root:root on this system
    -> currently empty
    -> permissions: drwxr-xr-x
```

Remember:

> `/srv` is conventionally used for data provided by system services.

**Part 2, item 15 complete.**
### 16. `/lost+found`

`/lost+found` is a directory commonly associated with filesystems that support filesystem recovery, particularly `ext2`, `ext3`, and `ext4`.

It provides a location where filesystem-recovery tools such as `fsck` can place recovered file fragments or files whose original directory locations could not be determined.

The directory is normally created at the top level of an applicable filesystem.

### Directory permissions and ownership

The command:

```bash
ls -ld /lost+found
```

produced:

```text
drwx------ 2 root root 16384 Aug 26 15:51 /lost+found
```

This shows:

```text
Owner: root
Group: root
Permissions: drwx------
```

Breaking down the permissions:

```text
d rwx --- ---
| |   |   |
| |   |   +-- Others: no permissions
| |   +------ Group: no permissions
| +---------- Owner: read, write, execute
+------------ Directory
```

Therefore, only the owner, `root`, has access according to the displayed Unix permission bits.

### Current contents

The command:

```bash
ls -la /lost+found
```

produced:

```text
ls: cannot open directory '/lost+found': Permission denied
```

Running the command again produced the same result:

```text
ls: cannot open directory '/lost+found': Permission denied
```

This is an important practical observation.

The directory exists, but the current user does not have sufficient permission to list its contents.

The permission bits explain why:

```text
drwx------ root root
```

Only `root` has the `r`, `w`, and `x` permissions on the directory.

### Why the permission denial occurs

For a directory:

* `r` allows listing directory entries.
* `w` allows creating, deleting, or renaming entries when the other required permissions are also present.
* `x` allows accessing entries and traversing the directory.

The current user does not have any permission bits granted through the group or others classes.

Therefore:

```text
/lost+found
    owner: root
    group: root
    user permissions: rwx
    group permissions: ---
    other permissions: ---
```

The current user cannot list the directory contents.

This demonstrates an important Linux concept: **the existence of a directory does not mean every user can inspect its contents.**

### Important filesystem observation

The presence of `/lost+found` can provide information about the filesystem layout, but its presence alone should not be treated as proof of a particular filesystem type.

Filesystem type should be verified with appropriate tools when needed, such as:

```bash
findmnt
lsblk -f
df -T
```

These commands can provide filesystem and mount information.

### RHCSA relevance

`/lost+found` is relevant to filesystem administration and troubleshooting.

Understanding it helps with:

* Linux filesystem structure
* Filesystem recovery
* `fsck` concepts
* Permissions
* Ownership
* Troubleshooting filesystem problems
* Understanding why recovered files may appear in a recovery directory

RHCSA filesystem administration requires understanding filesystems, mount points, permissions, and storage management, making this a useful directory to recognize.

### Security relevance

`/lost+found` demonstrates the importance of filesystem permissions.

On this system:

```text
drwx------ root root /lost+found
```

prevents the current user from listing its contents.

This is an example of access control being enforced by the filesystem.

During a security investigation, permission-denied results should be treated as evidence about the current user's access rights rather than immediately as evidence that something is wrong.

An administrator with appropriate privileges can inspect the directory when necessary.

### Quick revision

```text
/lost+found
    -> commonly associated with ext2/ext3/ext4 filesystems
    -> used by filesystem recovery processes
    -> located at the top level of an applicable filesystem
    -> owned by root:root on this system
    -> permissions: drwx------
    -> current user cannot list its contents
```

Remember:

> `/lost+found` is a filesystem recovery directory commonly found on ext-family filesystems, and its contents are controlled by normal Linux permissions.

**Part 2, item 16 complete.**
### 17. `/bin`, `/lib`, and `/sbin` Symlinks

On this system, `/bin`, `/lib`, and `/sbin` are symbolic links rather than independent directories.

They point into corresponding directories under `/usr`.

This is part of the modern merged `/usr` filesystem layout used by many Linux distributions.

### `/bin`

The command:

```bash
ls -ld /bin
```

produced:

```text
lrwxrwxrwx 1 root root 7 Jun 12 17:31 /bin -> usr/bin
```

The command:

```bash
readlink /bin
```

produced:

```text
usr/bin
```

Therefore:

```text
/bin -> /usr/bin
```

`/usr/bin` contains many executable programs available to normal users and system processes.

### `/lib`

The command:

```bash
ls -ld /lib
```

produced:

```text
lrwxrwxrwx 1 root root 7 Jun 12 17:31 /lib -> usr/lib
```

The command:

```bash
readlink /lib
```

produced:

```text
usr/lib
```

Therefore:

```text
/lib -> /usr/lib
```

`/usr/lib` contains libraries and other supporting files used by programs.

### `/sbin`

The command:

```bash
ls -ld /sbin
```

produced:

```text
lrwxrwxrwx 1 root root 8 Jun 12 17:31 /sbin -> usr/sbin
```

The command:

```bash
readlink /sbin
```

produced:

```text
usr/sbin
```

Therefore:

```text
/sbin -> /usr/sbin
```

`/usr/sbin` contains many system-administration utilities.

### Understanding the permission output

The first character in each result is:

```text
l
```

For example:

```text
lrwxrwxrwx
^
symbolic link
```

The `l` indicates that the filesystem object is a symbolic link.

The remaining permission-looking characters:

```text
rwxrwxrwx
```

are not interpreted in the same way as ordinary directory or file permissions for controlling access through the link. Access is ultimately determined by the target and the permissions of the relevant directories and files.

The output also shows:

```text
Owner: root
Group: root
```

for all three symbolic links.

### Resolving the links completely

The command:

```bash
readlink -f /bin
readlink -f /lib
readlink -f /sbin
```

produced:

```text
/usr/bin
/usr/lib
/usr/sbin
```

This confirms the final target of each symbolic link.

The relationship can therefore be represented as:

```text
/bin  -> /usr/bin
/lib  -> /usr/lib
/sbin -> /usr/sbin
```

### Why this matters

When navigating or investigating a Linux system, a path may be a symbolic link rather than a physical directory.

For example:

```bash
cd /bin
```

takes the user into the location represented by `/usr/bin`.

Likewise, programs referenced through `/bin` may actually reside under `/usr/bin`.

This means administrators should understand the difference between:

```text
Path presented to the user
        |
        v
Symbolic link
        |
        v
Actual target
```

### `readlink` versus `readlink -f`

The two commands provide different information.

```bash
readlink /bin
```

shows the link target as stored by the symbolic link:

```text
usr/bin
```

while:

```bash
readlink -f /bin
```

resolves the path to its final absolute location:

```text
/usr/bin
```

This distinction is useful when investigating filesystem paths.

### RHCSA relevance

Understanding symbolic links is directly relevant to Linux filesystem administration.

You should be able to:

* Recognize a symbolic link
* Read the target of a symbolic link
* Understand relative versus absolute link targets
* Resolve a symbolic link
* Navigate through symbolic links
* Understand how paths map to actual filesystem locations

Important commands include:

```bash
ls -l
readlink
readlink -f
```

### Security relevance

Symbolic links are important during security investigations because the visible path and the actual target can be different.

For example:

```text
/bin
  |
  v
/usr/bin
```

When investigating a suspicious or unexpected path, resolving symbolic links can help determine which actual filesystem object is being accessed.

Administrators should therefore distinguish between:

```text
symlink path
    |
    v
resolved target
    |
    v
target ownership and permissions
```

A symbolic link itself does not automatically make its target trusted or untrusted. The target and the permissions controlling access to it must be examined separately.

### Quick revision

```text
/bin
    -> /usr/bin

/lib
    -> /usr/lib

/sbin
    -> /usr/sbin
```

Actual observations:

```text
/bin  -> usr/bin
/lib  -> usr/lib
/sbin -> usr/sbin
```

Resolved paths:

```text
/usr/bin
/usr/lib
/usr/sbin
```

Remember:

> A symbolic link provides an alternate path to another filesystem location. Always resolve the link when the actual target matters.

**Part 2, item 17 complete.**
### 18. File Types: `d`, `-`, and `l`

The first character of an `ls -l` permission string identifies the type of filesystem object.

Three important types are:

```text
d  -> directory
-  -> regular file
l  -> symbolic link
```

This can be observed directly on this system.

### Directory: `d`

The command:

```bash
ls -ld /etc
```

produced:

```text
drwxr-xr-x 209 root root 12288 Sep 15 20:47 /etc
```

The first character is:

```text
d
```

Therefore, `/etc` is a directory.

The structure is:

```text
d rwxr-xr-x
^
|
directory
```

### Regular file: `-`

The command:

```bash
ls -l /etc/hostname
```

produced:

```text
-rw-r--r-- 1 root root 7 Aug 26 16:02 /etc/hostname
```

The first character is:

```text
-
```

A `-` indicates a regular file.

Therefore, `/etc/hostname` is a regular file.

The structure is:

```text
- rw-r--r--
^
|
regular file
```

### Symbolic link: `l`

The command:

```bash
ls -ld /bin
```

produced:

```text
lrwxrwxrwx 1 root root 7 Jun 12 17:31 /bin -> usr/bin
```

The first character is:

```text
l
```

A lowercase `l` indicates a symbolic link.

The output also shows the link target:

```text
/bin -> usr/bin
```

Therefore, `/bin` is a symbolic link pointing to `usr/bin`.

### Comparing the three types

The command:

```bash
ls -ld / /etc/hostname /bin
```

produced:

```text
drwxr-xr-x 18 root root 4096 Sep 15 00:22 /
lrwxrwxrwx  1 root root    7 Jun 12 17:31 /bin -> usr/bin
-rw-r--r--  1 root root    7 Aug 26 16:02 /etc/hostname
```

The first characters can be summarized as:

```text
d  /              -> directory
l  /bin           -> symbolic link
-  /etc/hostname  -> regular file
```

### Why the first character matters

When examining Linux permissions with `ls -l`, it is important not to read the permission string as only `rwx` information.

The first character provides information about the object itself.

For example:

```text
drwxr-xr-x
^
directory
```

```text
-rw-r--r--
^
regular file
```

```text
lrwxrwxrwx
^
symbolic link
```

The remaining characters describe the permission information associated with the object, subject to the particular object type.

### Other file types

Linux supports other filesystem object types as well.

Common examples include:

```text
d  -> directory
-  -> regular file
l  -> symbolic link
c  -> character device
b  -> block device
p  -> named pipe (FIFO)
s  -> socket
```

We have already observed examples of device objects under `/dev` during this lesson.

For example, `/dev` contains character and block device objects, while `/run` contains sockets and named pipes.

### RHCSA relevance

Recognizing filesystem object types is fundamental to Linux administration.

It helps with:

* Reading `ls -l` output
* Understanding permissions
* Identifying symbolic links
* Working with devices
* Troubleshooting filesystem paths
* Managing files and directories

The first character of an `ls -l` listing should become an immediate visual clue when examining a filesystem.

### Security relevance

File type identification is important during security investigations.

A path that appears to be a normal file may instead be:

* A symbolic link
* A device
* A socket
* A named pipe

For example, resolving a symbolic link can reveal the actual location being referenced:

```bash
readlink -f /bin
```

This prevents an administrator from assuming that the displayed path and the underlying filesystem object are always the same thing.

### Quick revision

```text
First character of ls -l:

d  -> directory
-  -> regular file
l  -> symbolic link
c  -> character device
b  -> block device
p  -> named pipe
s  -> socket
```

Actual observations from this system:

```text
/etc
    -> d
    -> directory

/etc/hostname
    -> -
    -> regular file

/bin
    -> l
    -> symbolic link
    -> usr/bin
```

Remember:

> The first character of an `ls -l` listing identifies the type of filesystem object.

**Part 2, item 18 complete.**
### 19. Directory Permissions

Linux directories have permission bits that control what different users can do with the directory.

A directory permission string follows the same basic structure seen with other filesystem objects:

```text
d rwx r-x r-x
|  |   |   |
|  |   |   +-- Others
|  |   +------ Group
|  +---------- Owner
+------------- Directory
```

The first character:

```text
d
```

identifies the object as a directory.

The remaining nine characters are divided into three permission classes:

```text
Owner
Group
Others
```

Each class can have:

```text
r  read
w  write
x  execute
```

### Example 1: `/etc`

The command:

```bash id="k1pr5d"
ls -ld /etc
```

produced:

```text id="p7e0tv"
drwxr-xr-x 209 root root 12288 Sep 15 20:47 /etc
```

The permission portion is:

```text id="3x3h2j"
drwxr-xr-x
```

Breaking it down:

```text id="4xyhgi"
d rwx r-x r-x
  |   |   |
  |   |   +-- Others
  |   +------ Group
  +---------- Owner
```

Therefore:

```text id="9a2zgi"
Owner:  rwx
Group:  r-x
Others: r-x
```

The directory is owned by:

```text id="4m9v7q"
root:root
```

### Example 2: `/home/fredrick`

The command:

```bash id="5q5efg"
ls -ld /home/fredrick
```

produced:

```text id="w3oqr2"
drwx------ 39 fredrick fredrick 4096 Sep 16 21:40 /home/fredrick
```

The permission portion is:

```text id="ypv5jz"
drwx------
```

This means:

```text id="7zqtd5"
Owner:  rwx
Group:  ---
Others: ---
```

The directory is owned by:

```text id="cfj7l4"
fredrick:fredrick
```

The displayed permissions provide the owner with access while providing no permissions through the group or others classes.

### Example 3: `/tmp`

The command:

```bash id="9v9q7c"
ls -ld /tmp
```

produced:

```text id="y20fbe"
drwxrwxrwt 20 root root 420 Sep 16 22:01 /tmp
```

The permission portion is:

```text id="f0d5oc"
drwxrwxrwt
```

The first nine permission positions are:

```text id="xg2u8p"
rwx rwx rwx
```

with an additional special permission represented by:

```text id="zv5l8m"
t
```

The `t` is the sticky bit.

Therefore, `/tmp` has:

```text id="eqj8d3"
Owner:  rwx
Group:  rwx
Others: rwx
Sticky bit: enabled
```

The sticky bit is particularly important for shared writable directories because it restricts which users can remove or rename entries belonging to other users.

We will examine directory `r`, `w`, and `x` behavior more closely in item 20.

### Example 4: `/lost+found`

The command:

```bash id="3f3k1x"
ls -ld /lost+found
```

produced:

```text id="d9u8e4"
drwx------ 2 root root 16384 Aug 26 15:51 /lost+found
```

The permission portion is:

```text id="s9r0ml"
drwx------
```

Therefore:

```text id="d3s8vl"
Owner:  rwx
Group:  ---
Others: ---
```

The directory is owned by:

```text id="g1w2j4"
root:root
```

This matches our earlier observation that the current user received:

```text id="4h4g0q"
ls: cannot open directory '/lost+found': Permission denied
```

### Comparing the directories

The observed permissions can be summarized as:

```text id="qj7z3k"
Directory          Owner       Group       Others      Special
----------------------------------------------------------------
/etc               rwx         r-x         r-x         -
/home/fredrick     rwx         ---         ---         -
/tmp               rwx         rwx         rwx         sticky
/lost+found        rwx         ---         ---         -
```

The ownership also differs:

```text id="4w1zq8"
/etc               root:root
/home/fredrick     fredrick:fredrick
/tmp               root:root
/lost+found        root:root
```

This demonstrates that Linux permissions are applied according to both:

```text
ownership
+
permission bits
```

### Directory permissions are different from file permissions

A common mistake is to interpret directory permissions exactly like regular-file permissions.

For a regular file:

```text
r -> read file contents
w -> modify file contents
x -> execute the file
```

For a directory, the same letters control different operations involving directory entries and traversal.

The detailed meaning of directory `r`, `w`, and `x` is the focus of the next item.

### RHCSA relevance

Directory permissions are fundamental to RHCSA administration.

You should be able to:

* Read directory permission strings
* Identify owner and group
* Understand owner, group, and others
* Recognize special permissions such as the sticky bit
* Diagnose permission problems
* Correct directory ownership and permissions when required

Commands commonly used include:

```bash id="1m0h5j"
ls -ld
chmod
chown
chgrp
```

### Security relevance

Directory permissions are an important access-control boundary.

They determine who can interact with directory entries and traverse filesystem paths.

During security investigation, administrators should examine:

```text id="xj5c9f"
Directory
    |
    +-- Owner
    |
    +-- Group
    |
    +-- Owner permissions
    |
    +-- Group permissions
    |
    +-- Other permissions
    |
    +-- Special permissions
```

The `/tmp` example is particularly important because it demonstrates a world-writable directory with the sticky bit enabled.

### Quick revision

```text id="j4n3mb"
Directory permission structure:

d rwx r-x r-x
|  |   |   |
|  |   |   +-- Others
|  |   +------ Group
|  +---------- Owner
+------------- Directory
```

Observed examples:

```text id="c3y4s2"
/etc
    drwxr-xr-x

/home/fredrick
    drwx------

/tmp
    drwxrwxrwt

/lost+found
    drwx------
```

Remember:

> Directory permissions control how users can interact with the directory and its entries. The exact meaning of `r`, `w`, and `x` on directories differs from their meaning on regular files.

**Part 2, item 19 complete.**
## 20. Meaning of `r`, `w`, and `x` on Directories

Directory permissions have a different meaning from file permissions. On a directory, `r`, `w`, and `x` control different operations involving the directory itself and the entries stored inside it.

The three permissions are:

| Permission | Meaning on a directory                                                                                                       |
| ---------- | ---------------------------------------------------------------------------------------------------------------------------- |
| `r`        | Allows listing the names of entries in the directory                                                                         |
| `w`        | Allows creating, deleting, and renaming directory entries when the required access conditions are also satisfied             |
| `x`        | Allows entering/traversing the directory and accessing entries when their own permissions also allow the requested operation |

A useful way to remember this is:

* `r` = see the directory entries
* `w` = change the directory entries
* `x` = traverse the directory

### 20.1 `r` on a Directory

The `r` permission allows a user to read the directory's list of entries.

For example, if a directory has:

```text
drwxr-xr-x
```

the owner has `rwx`, while the group and others have `r-x`.

The `r` permission allows those users to obtain a listing of the directory entries, subject to the other required permissions.

However, being able to see a filename does not automatically mean that the user can access the file.

### 20.2 `w` on a Directory

The `w` permission allows modification of the directory's entries.

Depending on the other permissions available, this can include:

* Creating files
* Creating directories
* Removing entries
* Renaming entries

An important distinction is:

> Directory `w` does not mean "modify the contents of every file inside the directory."

For example, a user may have permission to modify the directory entries while still being unable to modify the contents of a particular file because that file has restrictive permissions.

This distinction is important when analyzing Linux permissions and security.

### 20.3 `x` on a Directory

The `x` permission allows traversal of the directory.

Traversal means that the user can pass through the directory when accessing a path.

For example:

```text
/home/fredrick/project/file.txt
```

To reach `file.txt`, the user needs the necessary `x` permission on the directories in the path.

The `x` permission therefore plays an important role in path traversal and access control.

### 20.4 Why `x` Is Important

Directory `x` is not the same as "execute this directory."

Directories are not normally executed like programs.

Instead, `x` means that the user is allowed to traverse the directory and access entries within it when the entries themselves permit the requested operation.

This is why directory `x` is essential when working with paths.

### 20.5 Actual System Observations

The following commands were used to examine directory permissions:

```bash
pwd
ls -ld /home/fredrick
ls -ld /tmp
ls -ld /etc
ls -ld /lost+found
```

The current working directory was:

```text
/home/fredrick/RHCSA-Linux-Security-Lab
```

The home directory permissions were:

```text
drwx------ 39 fredrick fredrick 4096 Sep 16 21:40 /home/fredrick
```

This means:

* Owner `fredrick`: `rwx`
* Group: `---`
* Others: `---`

The owner therefore has full directory access, while the group and others have no permissions on this directory.

The `/tmp` permissions were:

```text
drwxrwxrwt 20 root root 420 Sep 16 22:06 /tmp
```

This gives:

* Owner: `rwx`
* Group: `rwx`
* Others: `rwx`
* Sticky bit: `t`

The sticky bit is an additional directory permission that restricts who can remove or rename entries in a shared writable directory.

The `/etc` permissions were:

```text
drwxr-xr-x 209 root root 12288 Sep 15 20:47 /etc
```

This gives:

* Owner `root`: `rwx`
* Group `root`: `r-x`
* Others: `r-x`

The `/lost+found` permissions were:

```text
drwx------ 2 root root 16384 Aug 26 15:51 /lost+found
```

This gives:

* Owner `root`: `rwx`
* Group: `---`
* Others: `---`

Earlier testing of `/lost+found` also demonstrated that attempting to list its contents as the normal user resulted in:

```text
ls: cannot open directory '/lost+found': Permission denied
```

This provides a practical example of directory permissions restricting access.

### 20.6 Directory `r`, `w`, and `x` Are Independent

The permissions should be considered separately.

For example:

```text
r--
```

does not automatically provide traversal.

Similarly:

```text
-w-
```

does not mean the user can freely access every file in the directory.

And:

```text
--x
```

allows traversal without providing normal directory listing access.

This is why Linux permission analysis requires looking at all three permissions together.

### 20.7 Security Relevance

Directory permissions are important because they control how users interact with filesystem namespaces.

When investigating a security issue, ask:

1. Who owns the directory?
2. Which group owns it?
3. Who has `r`?
4. Who has `w`?
5. Who has `x`?
6. Is the directory shared?
7. Is the sticky bit set?
8. What permissions do the individual files have?
9. Can a user create, remove, or rename entries?
10. Can a user traverse the path?

A writable directory can be security-sensitive even when the files inside it are not writable. This is particularly important when the directory contains programs, configuration files, scripts, or other security-sensitive resources.

### 20.8 RHCSA Relevance

Understanding directory permissions is fundamental to RHCSA administration.

You need to be able to:

* Read permission strings.
* Identify owners and groups.
* Understand `rwx` semantics on directories.
* Diagnose permission-denied errors.
* Configure appropriate permissions.
* Understand special permissions such as the sticky bit.
* Reason about access to files through directory paths.

These concepts are used throughout user management, filesystem administration, troubleshooting, and security-related RHCSA tasks.

### 20.9 Key Review

Remember:

```text
Directory:

r = list entries
w = create/delete/rename entries
x = traverse/access the directory
```

The most important distinction is:

> `w` on a directory controls changes to directory entries; it does not automatically grant permission to modify the contents of every file inside the directory.

The permissions of the directory and the permissions of the individual file must be analyzed separately.
## 21. `/proc/cpuinfo`

`/proc/cpuinfo` is a virtual file provided by the Linux kernel that exposes information about the processors visible to the operating system.

It is part of the `/proc` virtual filesystem discussed earlier in this lesson. The information is generated by the kernel rather than stored as a normal file on disk.

This makes `/proc/cpuinfo` useful for examining CPU topology, processor capabilities, architecture information, and other processor-related details.

### 21.1 Inspecting `/proc/cpuinfo`

The first command used was:

```bash
head -40 /proc/cpuinfo
```

This displays the first 40 lines of the virtual file.

The output began with:

```text
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 23
model           : 96
model name      : AMD Ryzen 7 PRO 4750U with Radeon Graphics
stepping        : 1
microcode       : 0x860010f
cpu MHz         : 1396.934
cache size      : 512 KB
physical id     : 0
siblings        : 16
core id         : 0
cpu cores       : 8
```

The same information was then shown for another logical processor:

```text
processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 23
model           : 96
model name      : AMD Ryzen 7 PRO 4750U with Radeon Graphics
stepping        : 1
microcode       : 0x860010f
cpu MHz         : 1395.915
cache size      : 512 KB
physical id      : 0
core id         : 0
```

### 21.2 Processor Count

The following command counted the `processor` entries:

```bash
grep -c '^processor' /proc/cpuinfo
```

Actual output:

```text
16
```

This shows that the operating system currently exposes **16 logical processors**.

The CPU information also reports:

```text
cpu cores       : 8
siblings        : 16
```

The distinction is important:

* `cpu cores : 8` identifies the physical CPU cores reported by the system.
* `siblings : 16` represents the logical processors associated with the physical CPU.
* The operating system therefore sees 16 logical processors.

### 21.3 CPU Model

The following command extracted the CPU model:

```bash
grep '^model name' /proc/cpuinfo | head -1
```

Actual output:

```text
model name      : AMD Ryzen 7 PRO 4750U with Radeon Graphics
```

This identifies the processor model exposed to Linux.

### 21.4 Architecture and Capability Information

The following command examined several important fields:

```bash
grep -E '^(vendor_id|cpu family|model|cpu MHz|flags)' /proc/cpuinfo | head -10
```

The observed information included:

```text
vendor_id       : AuthenticAMD
cpu family      : 23
model           : 96
model name      : AMD Ryzen 7 PRO 4750U with Radeon Graphics
cpu MHz         : 1472.932
```

The output also contained a long `flags` field.

The flags describe CPU capabilities exposed to the operating system. The observed flags included capabilities such as:

```text
nx
aes
avx
avx2
smep
smap
sha_ni
svm
```

These are examples of different processor capabilities.

Some are particularly relevant to security:

* `nx` is associated with hardware support for preventing execution from certain memory regions.
* `smep` provides a CPU-level protection related to supervisor-mode execution.
* `smap` provides a CPU-level protection related to supervisor-mode access to user memory.
* `aes` indicates hardware support for AES instructions.
* `sha_ni` indicates hardware support for SHA-related instructions.
* `svm` indicates AMD virtualization support.

The exact flags available depend on the processor and the environment in which Linux is running.

### 21.5 CPU Frequency Observation

The `cpu MHz` value changed between observations.

For example, the first output showed:

```text
cpu MHz         : 1396.934
```

Another processor entry showed:

```text
cpu MHz         : 1395.915
```

The later command showed:

```text
cpu MHz         : 1472.932
```

These values should not be interpreted as a fixed CPU speed.

CPU frequency can change dynamically according to workload, power-management policy, thermal conditions, and other system factors.

Therefore, `/proc/cpuinfo` provides a snapshot of the processor state at the time the information was read.

### 21.6 Microcode

The output also showed:

```text
microcode       : 0x860010f
```

CPU microcode is low-level processor update information provided to the operating system.

Microcode updates can address processor behavior and hardware-level issues, including security-related issues.

For RHCSA purposes, the important point is to recognize the field and understand that `/proc/cpuinfo` exposes processor information supplied by the kernel.

### 21.7 CPU Topology

The output contained several topology-related fields:

```text
physical id     : 0
siblings        : 16
core id         : 0
cpu cores       : 8
```

These fields help describe how Linux sees the processor and its logical processing units.

Understanding the difference between physical cores and logical processors is useful when interpreting system resource information.

### 21.8 Security Observations

`/proc/cpuinfo` can provide useful information during security and system investigations.

For example, the CPU flags can reveal whether hardware security or virtualization-related capabilities are exposed to the operating system.

The observed system reported:

```text
nx
smep
smap
aes
sha_ni
svm
```

These observations demonstrate that processor capabilities can be examined from the Linux userspace through `/proc`.

However, the presence of a CPU flag alone should not be treated as proof that a particular security control is fully configured or effective in every situation. It indicates that the relevant processor capability is exposed.

### 21.9 RHCSA Relevance

Understanding `/proc/cpuinfo` supports RHCSA knowledge of:

* The `/proc` virtual filesystem.
* Hardware and system-state inspection.
* CPU and logical processor identification.
* System resource investigation.
* Troubleshooting.
* Understanding information exposed by the Linux kernel.

Although memorizing every `/proc/cpuinfo` field is unnecessary, you should be comfortable inspecting the file and extracting useful information with standard commands such as `head` and `grep`.

### 21.10 Key Review

Remember:

```text
/proc/cpuinfo
    |
    +-- Processor information
    +-- CPU model
    +-- Logical processor count
    +-- Core information
    +-- CPU frequency snapshot
    +-- CPU capabilities
    +-- Microcode information
```

Actual system observations:

```text
CPU vendor:       AuthenticAMD
CPU model:        AMD Ryzen 7 PRO 4750U with Radeon Graphics
CPU cores:        8
Logical CPUs:     16
CPU family:       23
CPU model number: 96
```

The most important concept is:

> `/proc/cpuinfo` is a kernel-provided virtual interface that exposes information about processors visible to Linux.

The next item is **Part 2, item 22: `/proc/meminfo`**.
## 22. `/proc/meminfo`

`/proc/meminfo` is a kernel-provided virtual file that exposes information about the system's memory usage and memory management state.

Like `/proc/cpuinfo`, it belongs to the `/proc` virtual filesystem. It is not a normal file containing permanently stored data. Linux generates the information from the current state of the system.

`/proc/meminfo` is useful for:

* Inspecting installed/visible system memory.
* Checking available memory.
* Understanding memory currently in use.
* Examining buffers and filesystem cache.
* Checking swap configuration and usage.
* Troubleshooting memory-related problems.

### 22.1 Inspecting `/proc/meminfo`

The first command used was:

```bash id="o5s8eq"
head -30 /proc/meminfo
```

The actual output included:

```text id="5v9g8m"
MemTotal:       15682400 kB
MemFree:         7272140 kB
MemAvailable:    9346172 kB
Buffers:          251576 kB
Cached:          1966624 kB
SwapCached:            0 kB
Active:          4726292 kB
Inactive:         833208 kB
Active(anon):    3541936 kB
Inactive(anon):        0 kB
Active(file):    1184356 kB
Inactive(file):   833208 kB
Unevictable:       22996 kB
Mlocked:           22996 kB
SwapTotal:             0 kB
SwapFree:              0 kB
```

The output contains many additional fields describing how Linux is managing physical memory.

### 22.2 `MemTotal`

The system reported:

```text id="zthg1u"
MemTotal:       15682400 kB
```

`MemTotal` represents the total amount of physical memory recognized by the Linux kernel.

The value is approximately **15 GB of RAM**.

It is reported in kibibyte-based units (`kB` as displayed by `/proc/meminfo`).

### 22.3 `MemFree`

The system reported approximately:

```text id="dfq9dw"
MemFree:         7290268 kB
```

`MemFree` represents memory that is currently completely unused.

It is important not to interpret `MemFree` as the only measure of memory that can be used by applications.

Linux deliberately uses available memory for useful purposes such as filesystem caching.

### 22.4 `MemAvailable`

The system reported:

```text id="e8yylz"
MemAvailable:    9364432 kB
```

`MemAvailable` is an estimate of how much memory can be made available to applications without requiring significant swapping.

For practical system administration, `MemAvailable` is generally more useful than looking at `MemFree` alone.

The distinction is important because Linux can use otherwise unused memory for caches while still making that memory available when applications need it.

### 22.5 `Buffers`

The system reported:

```text id="4p3y5q"
Buffers:          251668 kB
```

`Buffers` represents memory used for certain kernel block-device buffering purposes.

It is one component of the overall memory-management picture and should not be treated as ordinary application memory.

### 22.6 `Cached`

The system reported:

```text id="d2e2u5"
Cached:          1967080 kB
```

`Cached` represents memory used for filesystem/page caching.

Linux uses available RAM to cache data because accessing data from memory is faster than repeatedly reading it from storage.

Cache memory can be reclaimed when the memory is needed for other purposes.

### 22.7 `SwapCached`

The system reported:

```text id="z3a5po"
SwapCached:            0 kB
```

`SwapCached` represents memory pages that have both a swap location and are still present in physical memory.

The current system showed zero swap-cached memory.

### 22.8 Swap Information

The system reported:

```text id="x4h1hz"
SwapTotal:             0 kB
SwapFree:              0 kB
```

This indicates that the current system has **no active swap space reported by `/proc/meminfo`**.

Therefore:

* `SwapTotal` = 0
* `SwapFree` = 0
* `SwapCached` = 0

This is an observation about the current system configuration. It does not mean that Linux can never use swap; it means that no active swap space is currently reported.

Swap configuration will be studied in greater detail later in the RHCSA storage portion of the project.

### 22.9 Live-System Values

The first read showed:

```text id="yxz0v0"
MemFree:         7272140 kB
MemAvailable:    9346172 kB
```

A subsequent read showed:

```text id="y4jq6h"
MemFree:         7290268 kB
MemAvailable:    9364432 kB
```

The values changed slightly.

This is expected because `/proc/meminfo` exposes live kernel information. Programs and system services can allocate or release memory between two commands.

Therefore, `/proc/meminfo` should be treated as a snapshot of the system at the moment it is read.

### 22.10 Extracting Specific Fields

The following command was used to extract selected memory fields:

```bash id="jld9bv"
grep -E '^(MemTotal|MemFree|MemAvailable)' /proc/meminfo
```

This demonstrates an important Linux administration technique: instead of reading the entire virtual file, `grep` can extract only the fields needed for an investigation.

The memory and swap command was:

```bash id="0u5e2w"
grep -E '^(MemTotal|MemFree|MemAvailable|Buffers|Cached|SwapCached|SwapTotal|SwapFree)' /proc/meminfo
```

This combines regular-expression matching with `/proc/meminfo` to retrieve a focused set of values.

### 22.11 Security and Troubleshooting Relevance

Memory information can be useful during system troubleshooting and security investigations.

For example, an administrator may need to determine:

* Whether the system is running low on available memory.
* Whether memory usage is changing unexpectedly.
* Whether swap is configured.
* Whether applications or services are consuming significant memory.
* Whether system performance problems could be related to memory pressure.

However, a single `/proc/meminfo` snapshot does not establish the cause of a problem. It provides evidence about the current memory state that can be combined with other system information.

### 22.12 RHCSA Relevance

Understanding `/proc/meminfo` supports RHCSA skills involving:

* System-state inspection.
* Resource monitoring.
* Troubleshooting.
* Memory management.
* Swap awareness.
* Using standard command-line tools to extract system information.

You should be comfortable recognizing important fields such as:

```text id="nqq5k6"
MemTotal
MemFree
MemAvailable
Buffers
Cached
SwapTotal
SwapFree
```

You do not need to memorize every field in `/proc/meminfo`.

### 22.13 Key Review

Remember:

```text id="w8h0y1"
/proc/meminfo
    |
    +-- MemTotal       = total memory recognized by Linux
    +-- MemFree        = completely unused memory
    +-- MemAvailable   = estimated memory available to applications
    +-- Buffers        = kernel buffering memory
    +-- Cached         = filesystem/page cache
    +-- SwapCached     = swap-backed pages still cached in RAM
    +-- SwapTotal      = total active swap space
    +-- SwapFree       = unused active swap space
```

Actual system observations:

```text id="8d2b8e"
MemTotal:       15682400 kB
MemAvailable:    9364432 kB
SwapTotal:             0 kB
SwapFree:              0 kB
```

The most important concept is:

> `/proc/meminfo` provides a live kernel-generated view of memory and swap state.

The next item is **Part 2, item 23: CPU, memory, architecture, and swap observations**. This time we will combine the information already collected from `/proc/cpuinfo`, `/proc/meminfo`, and the earlier `uname` results rather than unnecessarily repeating the same investigations.
## 23. CPU, Memory, Architecture, and Swap Observations

The previous sections examined `/proc/cpuinfo` and `/proc/meminfo` separately. This section combines those observations with kernel architecture information to form a basic system-state profile.

This is an important Linux administration skill: rather than examining individual values in isolation, an administrator should be able to combine system information and describe the current environment accurately.

### 23.1 Architecture

The following command was used:

```bash id="n6z2px"
uname -m
```

Actual output:

```text id="f5kj2j"
x86_64
```

`x86_64` identifies the 64-bit x86 architecture exposed by the running Linux environment.

Architecture information is important because software packages, binaries, libraries, kernel components, and system configurations can depend on the processor architecture.

### 23.2 Running Kernel

The following command was used:

```bash id="3k6x2b"
uname -r
```

Actual output:

```text id="8x9x4f"
7.0.13+parrot7-amd64
```

This identifies the currently running kernel release.

The kernel version is useful when troubleshooting hardware support, system behavior, security issues, drivers, and kernel-related configuration.

### 23.3 CPU Model

The CPU model was obtained with:

```bash id="1l8x0q"
grep '^model name' /proc/cpuinfo | head -1
```

Actual output:

```text id="s7d1qo"
model name      : AMD Ryzen 7 PRO 4750U with Radeon Graphics
```

The system therefore reports an AMD Ryzen 7 PRO 4750U processor.

### 23.4 Logical Processors

The following command counted the processor entries:

```bash id="xqv3ik"
grep -c '^processor' /proc/cpuinfo
```

Actual output:

```text id="8j2f5x"
16
```

Linux currently exposes **16 logical processors**.

### 23.5 CPU Cores

The CPU information reports:

```text id="9p2z2f"
cpu cores       : 8
```

Therefore, the system reports:

* 8 CPU cores
* 16 logical processors

The distinction is important because a CPU can expose more logical processors than physical cores.

For system administration, resource monitoring tools commonly report the logical processors available to the operating system.

### 23.6 Memory

The following command extracted the total and available memory:

```bash id="5u1d9n"
grep -E '^(MemTotal|MemAvailable)' /proc/meminfo
```

Actual output:

```text id="q7z3y0"
MemTotal:       15682400 kB
MemAvailable:    9370152 kB
```

The system therefore reports approximately:

* 15 GB of total memory.
* 9 GB of currently available memory.

`MemAvailable` is an estimate of memory that can be made available to applications without significant swapping.

The value can change between commands because `/proc/meminfo` reflects live system state.

### 23.7 Swap

The following command checked the swap totals:

```bash id="4m4m91"
grep -E '^(SwapTotal|SwapFree)' /proc/meminfo
```

Actual output:

```text id="9v5k2h"
SwapTotal:             0 kB
SwapFree:              0 kB
```

This indicates that the system currently reports **no active swap space**.

The result was also checked using:

```bash id="k9t8c4"
swapon --show
```

The command produced no entries.

This provides a second observation supporting the conclusion that there are currently no active swap devices or swap files reported by `swapon`.

### 23.8 Combined System Profile

The observations collected throughout this part can be summarized as:

| Category           | Observation                                |
| ------------------ | ------------------------------------------ |
| Architecture       | `x86_64`                                   |
| Kernel             | `7.0.13+parrot7-amd64`                     |
| CPU                | AMD Ryzen 7 PRO 4750U with Radeon Graphics |
| CPU cores          | 8                                          |
| Logical processors | 16                                         |
| Total memory       | 15682400 kB                                |
| Available memory   | 9370152 kB                                 |
| Active swap        | None reported                              |
| Swap total         | 0 kB                                       |

This is a basic but useful system inventory.

### 23.9 Why These Observations Matter

These values provide a starting point for understanding the environment before performing administration or troubleshooting tasks.

For example:

* Architecture helps determine software compatibility.
* Kernel version helps identify the running kernel and investigate kernel-specific behavior.
* CPU information helps understand available processing resources.
* Memory information helps assess current resource availability.
* Swap information helps determine whether swap is currently configured and active.

The values should always be treated as observations of the current system rather than permanent characteristics. CPU frequency, available memory, process counts, and other system-state values can change over time.

### 23.10 Security Relevance

System-state information can also be useful during security investigations.

An administrator can use it to establish a baseline of the environment:

```text
Architecture
    |
Kernel
    |
CPU
    |
Memory
    |
Swap
```

Unexpected changes to system configuration may warrant further investigation.

For example, knowing whether swap is active can be relevant when examining memory pressure or understanding how the system handles memory under resource constraints.

Similarly, knowing the running kernel version is important when assessing compatibility and determining which kernel-specific behavior applies to the system.

These observations alone do not identify a security problem. They provide context for further investigation.

### 23.11 RHCSA Relevance

This exercise reinforces several RHCSA skills:

* Using `uname` to inspect system information.
* Using `/proc` to inspect kernel-provided information.
* Using `grep` to extract relevant fields.
* Understanding CPU and memory resources.
* Checking swap state.
* Building a basic system inventory.
* Using command output as evidence during troubleshooting.

The RHCSA requires practical command-line administration, so the ability to quickly inspect a system and understand the output is more important than memorizing every available field.

### 23.12 Key Review

The current environment can be summarized as:

```text id="y4f3cb"
Architecture:          x86_64
Kernel:                7.0.13+parrot7-amd64
CPU:                   AMD Ryzen 7 PRO 4750U
CPU cores:             8
Logical processors:    16
Total memory:          15682400 kB
Available memory:      9370152 kB
Active swap:           None
SwapTotal:             0 kB
SwapFree:              0 kB
```

The key lesson is:

> Linux system information becomes more useful when individual observations are combined into a coherent picture of the current system state.

The next item is **Part 2, item 24: Security observations**.
## 24. Security Observations

The filesystem and `/proc` investigations in this part provide several practical security observations.

The purpose of this section is not to identify vulnerabilities simply because a permission or system feature exists. Instead, the goal is to learn how Linux filesystem structure, permissions, processes, and kernel information can be used as evidence during security analysis.

### 24.1 `/etc` Is a Security-Sensitive Directory

The system reported:

```text id="w3k5ps"
drwxr-xr-x 209 root root 12288 Sep 15 20:47 /etc
```

The directory is owned by `root:root`.

The owner has:

```text id="x9r6km"
rwx
```

while group and others have:

```text id="v3m4fz"
r-x
```

This means ordinary users can generally traverse and read permitted configuration files under `/etc`, but they cannot modify the directory itself through their normal permissions.

This is important because `/etc` contains system configuration that can influence services, networking, authentication, users, scheduled tasks, and other system behavior.

### 24.2 `/etc/shadow` Is Protected

Earlier investigation showed:

```text id="d2u8vk"
/etc/shadow -rw-r----- root shadow
```

Attempting to read it as the normal user resulted in:

```text id="j5m0hx"
cat /etc/shadow
Permission denied
```

This demonstrates an important Linux security principle:

> Sensitive authentication information should have more restrictive permissions than ordinary configuration files.

The `/etc/passwd` file was readable by normal users, while `/etc/shadow` was protected.

This difference is intentional because the two files have different security requirements.

### 24.3 `/home/fredrick` Is Restricted

The home directory was observed as:

```text id="n8z4rq"
drwx------ 39 fredrick fredrick 4096 Sep 16 21:40 /home/fredrick
```

The permission structure is:

```text id="s7k3pd"
Owner:  rwx
Group:  ---
Other:  ---
```

This restricts access to the directory to its owner under the displayed permissions.

This is useful for protecting personal files, project data, credentials stored in user configuration locations, and other user-owned information.

### 24.4 `/tmp` Is Shared but Uses the Sticky Bit

The system reported:

```text id="p6v4xm"
drwxrwxrwt 20 root root 420 Sep 16 22:06 /tmp
```

The directory is writable by the owner, group, and others.

However, it also has the sticky bit:

```text id="q1b8na"
t
```

The sticky bit changes how deletion and renaming of entries in a shared writable directory are controlled.

This is important because `/tmp` is designed to allow multiple users and services to create temporary files.

Without appropriate protection, a shared writable directory could create opportunities for users to interfere with files belonging to other users.

### 24.5 `/lost+found` Is Restricted

The system reported:

```text id="z8m2qw"
drwx------ 2 root root 16384 Aug 26 15:51 /lost+found
```

Attempting to list it as the normal user produced:

```text id="c4n7sa"
ls: cannot open directory '/lost+found': Permission denied
```

This provides a direct example of Linux directory permissions preventing access.

The important security lesson is that permission-denied results are evidence of an access-control boundary. They should be investigated by determining:

* Who owns the resource?
* What permissions are assigned?
* What identity is making the request?
* Are supplementary groups involved?
* Are there additional access-control mechanisms such as ACLs or SELinux?

### 24.6 Directory Permissions and File Permissions Are Different

The investigation demonstrated that directory permissions and file permissions must be analyzed separately.

For a directory:

```text id="f3w8kd"
r = list directory entries
w = create/delete/rename entries
x = traverse the directory
```

For a regular file, the same letters have different practical meanings.

Therefore, finding a writable directory does not automatically mean that every file inside it is writable.

Likewise, finding a non-writable file does not automatically mean that the surrounding directory is secure.

The complete access path must be examined.

### 24.7 `/bin`, `/lib`, and `/sbin` Are Symbolic Links

The system reported:

```text id="r7n4vx"
 /bin -> usr/bin
 /lib -> usr/lib
 /sbin -> usr/sbin
```

These are symbolic links rather than independent directory trees.

This is relevant when investigating paths because the apparent path and the underlying target may differ.

The commands:

```bash id="m2x8rc"
readlink /bin
readlink -f /bin
```

demonstrate the difference between viewing the immediate symbolic-link target and resolving the complete path.

Understanding symbolic links is important when tracing executables, libraries, configuration files, and other resources.

### 24.8 `/proc` Exposes System Information

The `/proc` filesystem exposes information about the running kernel and processes.

Examples investigated in this lesson include:

```text id="k6x9rw"
/proc/cpuinfo
/proc/meminfo
/proc/<PID>
```

This information is valuable for administration and troubleshooting.

It can also provide useful context during security investigations.

For example, `/proc/<PID>` can be used to investigate a running process and its executable:

```bash id="b8w3nz"
readlink -f /proc/<PID>/exe
```

This connects process information to the executable actually associated with the process.

### 24.9 Process Ownership Matters

Earlier process investigation showed that Firefox was running under the normal user account rather than as root.

The important security principle is:

> A process normally operates with the permissions of its effective identity.

Therefore, a program running as `fredrick` does not automatically become a root process simply because the user account can use `sudo`.

This illustrates the principle of least privilege.

A process should have only the privileges required for its work.

### 24.10 File Ownership and Process Ownership Are Different Concepts

Security analysis requires distinguishing between:

* Who owns a file.
* Who owns a directory.
* Which user owns a process.
* Which user is currently logged in.
* Which user can perform privileged operations.

For example, the Firefox executable was owned by root:

```text id="r1x7cf"
/usr/lib/firefox-esr/firefox-esr -rwxr-xr-x root root
```

while the Firefox process itself was running as the normal user.

This is not contradictory.

The executable file can be owned and protected by `root`, while a normal user executes it under their own process identity.

### 24.11 Writable Directory Versus Writable File

An earlier security exercise considered:

```text id="s3v8qk"
/opt/tools/monitor -rwxr-xr-x root root
/opt/tools drwxrwxr-x root security
```

The important correction was:

The executable itself was **not writable** by the user merely because the containing directory was group-writable.

The security concern was the writable directory.

A user with appropriate directory permissions may be able to manipulate directory entries, such as removing, renaming, or replacing files, depending on the exact permissions and other controls.

This demonstrates why security analysis must distinguish:

```text
File content permissions
        versus
Directory entry permissions
```

### 24.12 Security Investigation Method

The observations in this lesson suggest a useful investigation sequence:

```text
1. Identify the resource
        |
2. Identify its type
        |
3. Check owner and group
        |
4. Check permissions
        |
5. Identify the accessing user/process
        |
6. Check the complete path
        |
7. Check symbolic links where relevant
        |
8. Check additional access controls when necessary
        |
9. Gather evidence
        |
10. Form a conclusion
```

This prevents premature conclusions based on a single permission string or process name.

### 24.13 Security Principle: Observe Before Concluding

A security observation is not automatically a security finding.

For example:

* A writable directory may be intentional.
* A root-owned executable may be normal.
* A process that initially looks unfamiliar may be legitimate.
* A symbolic link is not automatically suspicious.
* A `/proc` entry is not automatically evidence of compromise.

The correct approach is to collect evidence and understand the relationship between the resource, permissions, owner, process, and system configuration.

### 24.14 RHCSA Relevance

These observations reinforce RHCSA skills involving:

* Linux permissions.
* File and directory ownership.
* Users and groups.
* Symbolic links.
* Process identification.
* System information.
* Troubleshooting permission errors.
* Understanding persistent Linux security configuration.

RHCSA administration requires understanding how Linux access controls work in practice rather than simply memorizing permission notation.

### 24.15 Key Security Lessons

The most important observations from Part 2 are:

```text
/etc
    Root-owned system configuration
    Permissions must be interpreted carefully

/etc/shadow
    Highly restricted authentication information

/home/fredrick
    User-owned and restricted

/tmp
    Shared writable directory
    Sticky bit provides additional protection

/lost+found
    Root-owned and restricted

/bin /lib /sbin
    Symbolic links in the merged-/usr layout

/proc
    Kernel-provided information about processes and system state

Directory permissions
    Control access to directory entries and traversal

Process identity
    Determines the privileges available to the process
```

The central security lesson is:

> Linux security analysis requires examining identity, ownership, permissions, paths, processes, and system state together rather than judging a resource from a single observation.
## 25. Verification and Final Review

This final verification confirms the concepts and observations covered throughout Part 2.

The verification was performed against the current Linux environment.

### 25.1 Filesystem Directory Verification

The following command verified the major directories studied:

```bash
ls -ld / /root /home /etc /usr /var /tmp /opt /dev /proc /sys /run /boot /media /mnt /srv /lost+found
```

The system confirmed the expected directory structure.

Important observations included:

```text id="m8t2qx"
/                         root of the filesystem
/root                     root user's home directory
/home                     user home directories
/etc                      system configuration
/usr                      installed programs and shared resources
/var                      variable system data
/tmp                      temporary shared data
/opt                      optional/additional software
/dev                      device interfaces
/proc                     kernel/process virtual filesystem
/sys                      kernel/device virtual filesystem
/run                      runtime system data
/boot                     boot-related files
/media                    conventional removable-media mount location
/mnt                      conventional temporary mount location
/srv                      service-provided data
/lost+found               filesystem recovery directory
```

The actual permissions also confirmed important security observations.

For example:

```text id="x3f6v8"
/tmp         drwxrwxrwt
/lost+found  drwx------
/etc         drwxr-xr-x
/usr         drwxr-xr-x
/proc        dr-xr-xr-x
/sys         dr-xr-xr-x
```

### 25.2 Merged `/usr` Verification

The following command verified the symbolic links:

```bash
ls -ld /bin /lib /sbin
```

Actual output:

```text id="j6y2pf"
lrwxrwxrwx 1 root root 7 Jun 12 17:31 /bin -> usr/bin
lrwxrwxrwx 1 root root 7 Jun 12 17:31 /lib -> usr/lib
lrwxrwxrwx 1 root root 8 Jun 12 17:31 /sbin -> usr/sbin
```

This confirms that the system uses the merged `/usr` layout observed earlier.

The important lesson is that these paths are symbolic links:

```text id="u4n9wk"
/bin  -> /usr/bin
/lib  -> /usr/lib
/sbin -> /usr/sbin
```

### 25.3 CPU Verification

Architecture was verified with:

```bash
uname -m
```

Actual output:

```text id="q7f1vz"
x86_64
```

Logical processors were verified with:

```bash
grep -c '^processor' /proc/cpuinfo
```

Actual output:

```text id="p2h6kd"
16
```

CPU cores were verified with:

```bash
grep '^cpu cores' /proc/cpuinfo | head -1
```

Actual output:

```text id="a5k8nx"
cpu cores       : 8
```

Therefore, the current system reports:

Architecture:       x86_64
CPU cores:           8
Logical processors: 16
25.4 Memory Verification

The following command verified memory information:

grep -E '^(MemTotal|MemAvailable)' /proc/meminfo

Actual output:

MemTotal:       15682400 kB
MemAvailable:    9337844 kB

This confirms that Linux currently recognizes approximately 15 GB of memory and reports approximately 9 GB as available.

The available-memory value changed slightly between earlier observations.

That is expected because /proc/meminfo represents live system state.

25.5 Swap Verification

Swap was checked with:

grep -E '^(SwapTotal|SwapFree)' /proc/meminfo
swapon --show

The system reported:

SwapTotal:             0 kB
SwapFree:              0 kB

swapon --show produced no active swap entries.

Therefore:

Active swap:  None reported
SwapTotal:    0 kB
SwapFree:     0 kB
25.6 Review of All Part 2 Topics

Part 2 covered the following sequence:

#	Topic	Status
1	/ versus /root	Complete
2	/home	Complete
3	/etc	Complete
4	/usr	Complete
5	/var	Complete
6	/tmp	Complete
7	/opt	Complete
8	/dev	Complete
9	/proc	Complete
10	/sys	Complete
11	/run	Complete
12	/boot	Complete
13	/media	Complete
14	/mnt	Complete
15	/srv	Complete
16	/lost+found	Complete
17	/bin, /lib, /sbin symlinks	Complete
18	File types: d, -, l	Complete
19	Directory permissions	Complete
20	Meaning of r, w, x on directories	Complete
21	/proc/cpuinfo	Complete
22	/proc/meminfo	Complete
23	CPU, memory, architecture and swap observations	Complete
24	Security observations	Complete
25	Verification and review	Complete
25.7 Core Concepts to Remember

The Linux filesystem is hierarchical:

/
├── root
├── home
├── etc
├── usr
├── var
├── tmp
├── opt
├── dev
├── proc
├── sys
├── run
├── boot
├── media
├── mnt
├── srv
└── lost+found

Important virtual filesystems include:

/proc
/sys

They expose information generated by the running kernel rather than ordinary persistent files.

Important directory permissions are:

r = list directory entries
w = create/delete/rename entries
x = traverse the directory

Important file-type indicators include:

d = directory
- = regular file
l = symbolic link

The merged /usr layout means:

/bin  -> /usr/bin
/lib  -> /usr/lib
/sbin -> /usr/sbin

System-state information can be inspected through:

/proc/cpuinfo
/proc/meminfo
25.8 Current System Profile

The final verification established the following observations:

Architecture:          x86_64
Kernel:                7.0.13+parrot7-amd64
CPU:                   AMD Ryzen 7 PRO 4750U with Radeon Graphics
CPU cores:             8
Logical processors:    16
Total memory:          15682400 kB
Available memory:      9337844 kB
Active swap:           None reported
SwapTotal:             0 kB
SwapFree:              0 kB

These values describe the environment at the time of verification and may change as the system runs.

25.9 RHCSA Review

Part 2 establishes several foundations required for later RHCSA work:

Navigating the Linux filesystem hierarchy.
Recognizing important system directories.
Understanding directory permissions.
Understanding symbolic links.
Identifying common filesystem object types.
Reading ownership and permission information.
Inspecting kernel-provided system information.
Understanding CPU and memory information.
Checking swap state.
Using ls, grep, head, uname, readlink, and swapon.
Interpreting command output rather than simply executing commands.

These skills will be reused throughout the later lessons.

25.10 Security Review

Part 2 also established a security-oriented way of thinking:

Resource
   |
Type
   |
Owner / Group
   |
Permissions
   |
Path
   |
Process / User
   |
Additional controls
   |
Evidence
   |
Conclusion

The key principle is:

Do not determine whether something is secure or insecure from a single observation. Examine identity, ownership, permissions, paths, processes, and system state together.

25.11 Final Part 2 Conclusion

Part 2 has established a practical understanding of the Linux filesystem hierarchy and how Linux exposes system information.

The most important concepts to retain are:

/ is the filesystem root; /root is the root user's home directory.
Important system directories have specific administrative purposes.
/proc, /sys, /dev, and /run provide specialized interfaces to the running system.
Directory permissions have different meanings from regular-file permissions.
Symbolic links can redirect standard filesystem paths.
Ownership and permissions form an important part of Linux access control.
/proc/cpuinfo provides processor information.
/proc/meminfo provides memory information.
System-state values can change between observations.
Security conclusions should be based on evidence and context.

Part 2 is therefore complete and verified.