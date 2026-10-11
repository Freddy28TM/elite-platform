# Part 3 - Users, Groups, and Privileges

## 1. whoami

### Concept

The `whoami` command displays the username of the current effective user.

It answers a basic but important Linux question:

> Which user account is currently being used by this shell?

The command is especially useful when working with permissions, ownership, administrative privileges, and security-sensitive operations.

### Why It Matters

Linux permissions are applied according to user and group identities.

Before performing an administrative or security-related task, it is important to know which account is currently active. A command may behave differently depending on whether it is executed as a normal user or with elevated privileges.

Checking the current identity helps prevent mistakes such as:

* Assuming the shell is running as `root` when it is not.
* Assuming a command has administrative privileges when it does not.
* Modifying files without understanding which account is performing the operation.
* Confusing the normal user identity with an elevated identity.

### Command Syntax

```bash
whoami
```

The command does not require an option or argument for its normal use.

### Actual Command

The command was executed from the RHCSA project directory:

```bash
cd ~/RHCSA-Linux-Security-Lab
whoami
```

### Actual Output

```text
fredrick
```

### Observation

The current effective user is:

```text
fredrick
```

This shows that the shell is operating under the `fredrick` user identity.

The output is the username associated with the current effective user ID.

### Important Distinction

`whoami` tells us the **effective user identity**.

It does not display:

* The user's UID.
* The user's primary GID.
* The user's supplementary groups.
* The user's home directory.
* The user's shell.
* Whether the user can use `sudo`.

Those details can be investigated with other commands later in this part, particularly `id`, `groups`, and `getent`.

### RHCSA Relevance

Understanding the current user identity is fundamental to RHCSA administration tasks involving:

* File ownership.
* File and directory permissions.
* User administration.
* Group membership.
* Privileged commands.
* `sudo`.
* System configuration.

Knowing who is performing an operation is an important first step before troubleshooting permission-related problems.

### Security Relevance

User identity is one of the foundations of Linux access control.

A security investigation should establish the identity of the process or shell performing an action before evaluating whether that action should be permitted.

The result:

```text
fredrick
```

establishes the normal user identity observed in this shell.

This does not mean that every command executed from the shell necessarily runs with only the privileges of `fredrick`. Privilege elevation mechanisms such as `sudo` can change the effective identity for an individual command. That distinction will be examined later in Part 3.

### Verification

Run:

```bash
whoami
```

Expected result in the current environment:

```text
fredrick
```

### Quick Review

**What does `whoami` display?**

The username of the current effective user.

**Why should an administrator check it?**

To establish which user identity is currently performing commands before working with permissions, ownership, or privileged operations.

**Does `whoami` show the UID and groups?**

No. Those details require additional commands such as `id`.

**Current observed user:**

```text
fredrick
```
## 2. id

### Concept

The `id` command displays identity information for the current user or another specified user.

Unlike `whoami`, which displays only the effective username, `id` provides the user's:

* User ID (UID)
* Primary group ID (GID)
* Primary group name
* Supplementary group IDs
* Supplementary group names

This makes `id` an important command for understanding Linux identity and access control.

### Why It Matters

Linux does not determine access using usernames and group names alone. Internally, Linux uses numeric user IDs and group IDs.

The `id` command allows an administrator to see the relationship between:

```text
username -> UID
primary group -> GID
supplementary groups -> additional group memberships
```

This information is important when investigating permissions, ownership, administrative privileges, and access to resources.

### Command Syntax

```bash id="3q7j6m"
id
```

The command can also be used with a username:

```bash id="k1z8rp"
id username
```

When used without an argument, `id` reports information about the current user.

### Actual Command

The command was executed from the RHCSA project directory:

```bash id="6c4m2x"
cd ~/RHCSA-Linux-Security-Lab
id
```

### Actual Output

```text
uid=1000(fredrick) gid=1002(fredrick) groups=1002(fredrick),20(dialout),24(cdrom),25(floppy),27(sudo),29(audio),30(dip),44(video),46(plugdev),101(netdev),103(scanner),112(bluetooth),117(lpadmin),1000(docker),1001(podman)
```

### Understanding the Output

The output begins with:

```text id="c7r2w5"
uid=1000(fredrick)
```

This means the current user is `fredrick` and the user's numeric UID is `1000`.

The next field is:

```text id="v8m1qa"
gid=1002(fredrick)
```

This identifies the user's primary group. The primary group has GID `1002` and is named `fredrick`.

The `groups=` field contains the primary group followed by supplementary groups:

```text id="m3t6ys"
groups=1002(fredrick),20(dialout),24(cdrom),25(floppy),27(sudo),29(audio),30(dip),44(video),46(plugdev),101(netdev),103(scanner),112(bluetooth),117(lpadmin),1000(docker),1001(podman)
```

These memberships can affect which resources the user can access.

### UID

UID means **User ID**.

Linux uses the UID internally to identify a user.

In this environment:

```text id="p4k8jd"
UID: 1000
Username: fredrick
```

The username is the human-readable representation, while the UID is the numeric identity used internally by the operating system.

### GID

GID means **Group ID**.

The current user's primary group is:

```text id="x9s2vc"
GID: 1002
Group: fredrick
```

A user's primary group is the default group associated with the user's account.

### Supplementary Groups

Supplementary groups provide additional group memberships beyond the primary group.

The observed supplementary memberships include:

```text id="h6n4pw"
dialout
cdrom
floppy
sudo
audio
dip
video
plugdev
netdev
scanner
bluetooth
lpadmin
docker
podman
```

Group membership can grant access to resources controlled by those groups.

For example, membership in the `sudo` group is relevant to administrative privilege because the system's sudo policy can allow members of that group to execute commands with elevated privileges.

Membership in groups such as `docker` and `podman` is also security-relevant because access to container-management facilities can provide significant system capabilities depending on the system configuration.

Group membership should therefore be treated as part of a user's effective access context.

### `id` Compared With `whoami`

The two commands answer different questions.

| Command  | Main information                        |
| -------- | --------------------------------------- |
| `whoami` | Current effective username              |
| `id`     | UID, primary GID, and group memberships |

For example:

```text
whoami -> fredrick
```

while `id` provides the more complete identity information:

```text
uid=1000(fredrick)
gid=1002(fredrick)
groups=...
```

### Security Relevance

`id` is useful during security investigations because group membership can significantly affect what a user can access or administer.

A security review should therefore consider more than the username alone.

The identity context includes:

```text
User
UID
Primary group
GID
Supplementary groups
```

The observed account belongs to the `sudo`, `docker`, and `podman` groups, among others. These memberships are important observations for later privilege and access-control analysis.

This observation does not by itself prove that the user currently has unrestricted administrative access. Actual privilege depends on the applicable system configuration and authorization rules.

### RHCSA Relevance

Understanding UID, GID, primary groups, and supplementary groups is fundamental to RHCSA tasks involving:

* User accounts
* Groups
* File ownership
* File permissions
* Privileged access
* `sudo`
* Troubleshooting permission problems

The `id` command is therefore a practical tool for verifying identity information during administration tasks.

### Verification

Run:

```bash id
```

Expected result in the current environment will identify the current user's UID, primary GID, and group memberships.

The exact supplementary groups can change if group membership is modified, so verification should use the current system output rather than relying on an old copy.

### Quick Review

**What does UID mean?**

User ID, the numeric identity assigned to a user.

**What does GID mean?**

Group ID, the numeric identity assigned to a group.

**What is the primary group?**

The main group associated with the user's account.

**What are supplementary groups?**

Additional groups to which the user belongs.

**Why is `id` useful for security analysis?**

Because group membership can affect the resources and privileges available to a user.

**Observed UID:**

```text
1000
```

**Observed primary GID:**

```text
1002
```

**Observed username:**

```text
fredrick
```
 ## 3. `groups`

### Concept

The `groups` command displays the groups to which the current user belongs.

It focuses specifically on group membership, making it useful when checking whether a user belongs to a group that controls access to files, devices, services, or administrative functions.

Unlike `id`, which displays the UID, GID, and detailed identity information, `groups` provides a concise list of group names.

### Why It Matters

Linux uses groups to organize access to shared resources.

A user's group memberships can affect access to:

* Files and directories
* Devices
* System resources
* Services
* Administrative functions
* Container-management facilities

Checking group membership is therefore an important part of troubleshooting permission problems and understanding a user's access context.

### Command Syntax

```bash
groups
```

The command can also be used with a username:

```bash
groups username
```

When used without an argument, `groups` displays the groups associated with the current user.

### Actual Command

The command was executed from the RHCSA project directory:

```bash
cd ~/RHCSA-Linux-Security-Lab
groups
```

### Actual Output

```text
fredrick dialout cdrom floppy sudo audio dip video plugdev netdev scanner bluetooth lpadmin docker podman
```

### Understanding the Output

The first entry is the user's primary group:

```text
fredrick
```

The remaining entries represent additional groups associated with the account:

```text
dialout
cdrom
floppy
sudo
audio
dip
video
plugdev
netdev
scanner
bluetooth
lpadmin
docker
podman
```

The output provides a quick human-readable view of the user's group memberships.

### Group Membership and Access

Group membership can affect whether a user can access resources controlled by a particular group.

For example, this account belongs to:

```text
sudo
docker
podman
```

These memberships are security-relevant because the permissions and authorization rules associated with these groups can provide access to administrative or container-management capabilities.

However, group membership alone does not establish exactly what actions are permitted. The applicable system configuration and authorization policies must also be examined.

### `groups` Compared With `id`

Both commands can display group membership, but they provide different levels of information.

| Command  | Main information                      |
| -------- | ------------------------------------- |
| `groups` | Group names associated with a user    |
| `id`     | UID, primary GID, and group IDs/names |

For example:

```text
groups -> fredrick dialout cdrom floppy sudo ...
```

while `id` provides the corresponding numeric identity information:

```text
uid=1000(fredrick)
gid=1002(fredrick)
groups=1002(fredrick),20(dialout),...
```

Therefore, `groups` is useful for a quick group-membership check, while `id` provides a more complete identity view.

### Security Relevance

`groups` is useful during security investigations because unexpected or unnecessary group membership can change a user's access to system resources.

A security review should therefore consider:

```text
User
Primary group
Supplementary groups
Resource ownership
Resource permissions
Authorization rules
```

The observed account belongs to groups including `sudo`, `docker`, and `podman`. These are important observations for later access-control and privilege analysis.

The presence of a group in the output should not automatically be treated as proof of unrestricted privilege. The actual effect depends on system configuration and the permissions associated with that group.

### RHCSA Relevance

Understanding group membership is fundamental to RHCSA tasks involving:

* Local groups
* User accounts
* Group membership
* File ownership
* File permissions
* Access-control troubleshooting
* Privileged access

The `groups` command provides a quick way to verify group membership during administration tasks.

### Verification

Run:

```bash
groups
```

Expected result:

```text
fredrick dialout cdrom floppy sudo audio dip video plugdev netdev scanner bluetooth lpadmin docker podman
```

The exact output can change if the user's group memberships are modified. Verification should therefore use the current system output.

### Quick Review

**What does `groups` display?**

The groups associated with a user.

**Why is group membership important?**

Groups can control access to shared resources and system functions.

**How does `groups` differ from `id`?**

`groups` provides a concise group-name listing, while `id` provides detailed UID, GID, and group information.

**Observed primary group:**

```text
fredrick
```

**Observed supplementary groups include:**

```text
dialout
cdrom
floppy
sudo
audio
dip
video
plugdev
netdev
scanner
bluetooth
lpadmin
docker
podman
```
## 4. UID and GID

### Concept

Linux identifies users and groups internally using numeric identifiers.

Two important identifiers are:

* UID - User ID
* GID - Group ID

The UID identifies a user, while the GID identifies a group.

Linux uses these numeric identifiers when determining ownership and applying access-control rules.

### Why It Matters

Usernames and group names are human-readable labels, but Linux internally associates them with numeric IDs.

Understanding UID and GID is important when working with:

* File ownership
* Directory ownership
* User accounts
* Groups
* Permissions
* Access-control troubleshooting
* Privileged access

For example, a file may appear to be owned by `fredrick`, but the operating system ultimately associates that ownership with the corresponding numeric UID.

### Commands

Display the current user's numeric UID:

```bash id="p8g6n2"
id -u
```

Display the current user's numeric primary GID:

```bash id="n5r2vk"
id -g
```

Display the current username:

```bash id="q4j7mc"
id -un
```

Display the current primary group name:

```bash id="w1t9sf"
id -gn
```

### Command Options

The `-u` option requests the user ID.

The `-g` option requests the effective primary group ID.

The `-un` options request the username associated with the user ID.

The `-gn` options request the group name associated with the primary group ID.

These options make `id` useful when a script or administrator needs a specific identity value rather than the complete `id` output.

### Actual Commands

The commands were executed from the RHCSA project directory:

```bash id="j5v3qx"
cd ~/RHCSA-Linux-Security-Lab

echo "===== UID ====="
id -u

echo
echo "===== GID ====="
id -g

echo
echo "===== UID AND GID WITH NAMES ====="
id -un
id -gn
```

### Actual Output

```text id="r6k2mp"
===== UID =====
1000

===== GID =====
1002

===== UID AND GID WITH NAMES =====
fredrick
fredrick
```

### Understanding the UID

The command:

```bash id="m4t8cx"
id -u
```

returned:

```text id="v2q9la"
1000
```

This means the current user's UID is `1000`.

The corresponding username is:

```text id="c7n3wd"
fredrick
```

Therefore:

```text id="z5p1hr"
UID 1000 -> fredrick
```

The UID is the numeric identity Linux uses to associate processes and file ownership with the user account.

### Understanding the GID

The command:

```bash id="s8k4jf"
id -g
```

returned:

```text id="h3m7qb"
1002
```

This means the current user's primary GID is `1002`.

The corresponding primary group name is:

```text id="d9x6tk"
fredrick
```

Therefore:

```text id="r1c5vm"
GID 1002 -> fredrick
```

### UID and File Ownership

UIDs are important when examining file ownership.

For example, when a file is displayed as being owned by:

```text id="e8q2ns"
fredrick
```

the system associates that ownership with the user's UID.

This becomes particularly useful when troubleshooting permissions because ownership can be examined using both names and numeric IDs.

### GID and Group Ownership

GIDs are similarly used for group ownership.

When a file is displayed as belonging to group:

```text id="u6w4pk"
fredrick
```

the system associates that group ownership with GID `1002`.

This relationship becomes important when checking whether a user can access a resource through group permissions.

### Names Versus Numeric IDs

Linux commonly displays usernames and group names because they are easier for administrators to understand.

Internally, however, the operating system works with numeric identifiers.

The observed relationships are:

```text id="k9s2df"
Username: fredrick
UID: 1000

Primary group: fredrick
GID: 1002
```

Understanding both representations helps when interpreting ownership and permission information.

### Security Relevance

UID and GID values are part of the identity context used by Linux access-control mechanisms.

A security investigation should not rely only on the visible username. It should also consider:

```text id="b3h7qx"
UID
GID
Primary group
Supplementary groups
File ownership
Process ownership
Permissions
```

This is especially useful when investigating permission problems or determining which account owns a process or resource.

Numeric IDs can also be useful when reviewing system configuration and ownership information where names may not be displayed.

### RHCSA Relevance

UID and GID concepts are fundamental to RHCSA tasks involving:

* Creating and managing users
* Creating and managing groups
* File ownership
* File permissions
* User and group administration
* Troubleshooting access problems
* Privileged access

The `id` command provides a quick way to verify these identity values.

### Verification

Run:

```bash id="e4v8rc"
id -u
id -g
id -un
id -gn
```

Expected values in the current environment:

```text id="q7m3hs"
1000
1002
fredrick
fredrick
```

The numeric values can differ between systems and accounts, so verification should always use the current system rather than assuming that UID `1000` or GID `1002` will be universal.

### Quick Review

**What is a UID?**

A numeric User ID used by Linux to identify a user.

**What is a GID?**

A numeric Group ID used by Linux to identify a group.

**What is the observed UID?**

```text id="n2f6ya"
1000
```

**What is the observed primary GID?**

```text id="p5r8kc"
1002
```

**What username corresponds to UID `1000` in this environment?**

```text id="x3v7mj"
fredrick
```

**What primary group corresponds to GID `1002` in this environment?**

```text id="t8q4nb"
fredrick
```
## 5. Supplementary Groups

### Concept

Supplementary groups are additional groups associated with a user account beyond the user's primary group.

Linux can use supplementary group membership when determining whether a user can access files, directories, devices, services, and other resources.

The `id` command can display the numeric group IDs and group names associated with the current user.

### Why It Matters

A user's access is not determined only by the user's primary group.

Supplementary group membership can provide additional access to resources that are assigned to those groups.

Understanding supplementary groups is therefore important when:

* Troubleshooting permission problems
* Managing users and groups
* Investigating access to devices
* Reviewing privileged access
* Checking file and directory permissions
* Investigating security-sensitive group membership

### Commands

Display all group IDs associated with the current user:

```bash id="v7q2mc"
id -G
```

Display all group names associated with the current user:

```bash id="k4n8sd"
id -Gn
```

The `-G` option requests all group IDs associated with the user.

The `-Gn` options request the corresponding group names instead of numeric IDs.

### Actual Commands

The commands were executed from the RHCSA project directory:

```bash id="j6t3pw"
cd ~/RHCSA-Linux-Security-Lab

echo "===== SUPPLEMENTARY GROUPS ====="
id -G

echo
echo "===== SUPPLEMENTARY GROUP NAMES ====="
id -Gn
```

### Actual Output

```text id="r9m5xf"
===== SUPPLEMENTARY GROUPS =====
1002 20 24 25 27 29 30 44 46 101 103 112 117 1000 1001

===== SUPPLEMENTARY GROUP NAMES =====
fredrick dialout cdrom floppy sudo audio dip video plugdev netdev scanner bluetooth lpadmin docker podman
```

### Understanding `id -G`

The command:

```bash id="p3w8hj"
id -G
```

returned:

```text id="y5c2qn"
1002 20 24 25 27 29 30 44 46 101 103 112 117 1000 1001
```

These are the group IDs associated with the current user's group membership.

The first value, `1002`, corresponds to the user's primary group.

The remaining group IDs correspond to additional group memberships.

Therefore, the output represents the complete group-ID set associated with the current user rather than only the supplementary groups.

### Understanding `id -Gn`

The command:

```bash id="s2v7kd"
id -Gn
```

returned:

```text id="a8m4rx"
fredrick dialout cdrom floppy sudo audio dip video plugdev netdev scanner bluetooth lpadmin docker podman
```

This is the same group-membership information expressed as group names rather than numeric IDs.

The first group is:

```text id="q6f9wc"
fredrick
```

which is the observed primary group.

The remaining groups are additional group memberships.

### Observed Group Memberships

The observed primary group is:

```text id="m7x3kp"
fredrick
```

The observed additional memberships include:

```text id="c5r8vn"
dialout
cdrom
floppy
sudo
audio
dip
video
plugdev
netdev
scanner
bluetooth
lpadmin
docker
podman
```

These memberships form part of the user's access context.

### Primary Group Versus Supplementary Groups

It is important to distinguish the primary group from supplementary groups.

In the observed account:

```text id="u4n9bs"
Primary group:
fredrick

Additional group memberships:
dialout
cdrom
floppy
sudo
audio
dip
video
plugdev
netdev
scanner
bluetooth
lpadmin
docker
podman
```

The `id -G` and `id -Gn` commands display the complete group set, so the primary group appears in their output as well.

### Security Relevance

Supplementary group membership can have significant security implications because group permissions may provide access to resources beyond those available through the user's primary group.

The observed account belongs to groups including:

```text id="e2k6jq"
sudo
docker
podman
```

These memberships are relevant to later privilege and access-control analysis.

However, membership in a group does not by itself establish exactly what actions the user can perform. The effect depends on the system's configuration, group ownership, file permissions, service configuration, and authorization rules.

A security review should therefore examine both group membership and the resources controlled by those groups.

### Example Access-Control Relationship

A simplified access-control relationship can be represented as:

```text id="h8p4mz"
User
  |
  +-- Primary group
  |
  +-- Supplementary group
          |
          +-- Resource ownership
          |
          +-- Resource permissions
          |
          +-- Possible access
```

This demonstrates why group membership should be considered when investigating access to a resource.

### RHCSA Relevance

Supplementary groups are directly relevant to RHCSA administration tasks involving:

* User accounts
* Group membership
* File ownership
* File permissions
* Access-control troubleshooting
* Privileged access

Administrators should be able to identify a user's groups and understand how those memberships affect access.

### Verification

Run:

```bash id="n3x7vf"
id -G
id -Gn
```

Expected values in the current environment:

```text id="w6q2ck"
1002 20 24 25 27 29 30 44 46 101 103 112 117 1000 1001
```

and:

```text id="b9m5rt"
fredrick dialout cdrom floppy sudo audio dip video plugdev netdev scanner bluetooth lpadmin docker podman
```

Group membership can change when groups are added or removed from an account. Verification should therefore use the current system output.

### Quick Review

**What are supplementary groups?**

Additional groups associated with a user beyond the primary group.

**What does `id -G` display?**

The numeric IDs of all groups associated with the user.

**What does `id -Gn` display?**

The names of all groups associated with the user.

**Does `id -G` display only supplementary groups?**

No. It displays the complete group set, including the primary group.

**Observed primary group:**

```text id="f4j8yd"
fredrick
```

**Observed additional group memberships include:**

```text id="r2v6mh"
dialout
cdrom
floppy
sudo
audio
dip
video
plugdev
netdev
scanner
bluetooth
lpadmin
docker
podman
```
## 6. `getent passwd`

### Concept

The `getent` command retrieves entries from databases configured through the Name Service Switch (NSS) system.

The `passwd` database contains user-account information.

When used as:

```bash id="r7m2kc"
getent passwd
```

the command displays available user-account entries.

When a specific username is supplied:

```bash id="x4n8vd"
getent passwd username
```

it retrieves the entry for that particular user.

### Why It Matters

User-account information is used throughout Linux for identity and access control.

`getent passwd` is useful because it queries the system's configured account database rather than simply reading `/etc/passwd` directly.

This makes it useful for administration and troubleshooting because Linux can obtain account information through different NSS sources.

The command can therefore help answer questions such as:

* Does a user account exist?
* What UID belongs to the account?
* What is the user's primary GID?
* What is the user's home directory?
* What login shell is configured?

### Command Syntax

Display all passwd database entries:

```bash id="m9c5wp"
getent passwd
```

Display one specific user's entry:

```bash id="t3v8qn"
getent passwd username
```

In this exercise:

```bash id="j6k2rf"
getent passwd fredrick
```

### Actual Command

The command was executed from the RHCSA project directory:

```bash id="p8d4mx"
cd ~/RHCSA-Linux-Security-Lab

echo "===== CURRENT USER ====="
getent passwd fredrick
```

### Actual Output

```text id="y5q7hc"
===== CURRENT USER =====
fredrick:x:1000:1002:FREDRICK :/home/fredrick:/bin/bash
```

### Understanding the Output

The returned record contains several colon-separated fields:

```text id="c9v4ks"
fredrick:x:1000:1002:FREDRICK :/home/fredrick:/bin/bash
```

The fields are:

```text id="n2h6pz"
1. Username
2. Password field
3. UID
4. Primary GID
5. GECOS/comment field
6. Home directory
7. Login shell
```

### Field 1 - Username

The first field is:

```text id="w8r3mf"
fredrick
```

This is the username associated with the account.

### Field 2 - Password Field

The second field is:

```text id="q5j9vx"
x
```

The `x` indicates that the password hash is stored separately rather than directly in this field.

On systems using the traditional local shadow-password arrangement, the password hash is stored in `/etc/shadow`.

The actual password hash should not normally be exposed through `/etc/passwd`.

### Field 3 - UID

The third field is:

```text id="a7k2nd"
1000
```

This is the account's UID.

It matches the UID previously observed with:

```bash id="z6p4yt"
id -u
```

which returned:

```text id="s3m8qc"
1000
```

### Field 4 - Primary GID

The fourth field is:

```text id="h9v5rx"
1002
```

This is the account's primary GID.

It matches the previously observed primary GID:

```text id="b4k7wp"
1002
```

### Field 5 - GECOS/Comment Field

The fifth field is:

```text id="d6n2qm"
FREDRICK
```

This field is commonly used for descriptive information associated with the account, such as a user's full name or other account-related information.

In the observed output, the value contains a trailing space after `FREDRICK`.

### Field 6 - Home Directory

The sixth field is:

```text id="r8c3fj"
 /home/fredrick
```

This identifies the user's home directory.

The home directory is where the user's personal files and user-specific configuration are normally stored.

### Field 7 - Login Shell

The final field is:

```text id="m5q9vk"
/bin/bash
```

This identifies the user's configured login shell.

For this account, the configured shell is Bash.

### Relationship to `id`

The information returned by `getent passwd fredrick` helps explain information previously observed with `id`.

The account record shows:

```text id="x7p2mc"
Username: fredrick
UID: 1000
Primary GID: 1002
Home: /home/fredrick
Shell: /bin/bash
```

The `id` command then reports the user's identity and group memberships using that account information.

### `getent passwd` Versus `/etc/passwd`

These commands are related but are not identical in purpose.

```text id="v4n8qs"
getent passwd
```

queries the configured NSS passwd database.

By contrast:

```bash id="k6m3wp"
cat /etc/passwd
```

directly reads the local `/etc/passwd` file.

The `getent` approach is useful because NSS can be configured to obtain account information from sources other than the local file.

### Security Relevance

`getent passwd` is useful during security and administration investigations because it reveals important account attributes.

For a user account, an administrator can establish:

```text id="p3r8yh"
Username
UID
Primary GID
Home directory
Login shell
```

The configured shell is particularly relevant when determining how an account is intended to interact with the system.

The passwd database does not contain the user's password hash in this environment; the password field contains `x`, with password information handled separately through the shadow-password mechanism.

### RHCSA Relevance

`getent passwd` is useful for RHCSA tasks involving:

* User accounts
* UID and GID identification
* Account troubleshooting
* Home directories
* Login shells
* Local account administration
* Understanding passwd and shadow databases

It is also useful for verifying that account information is being resolved correctly through the system's configured NSS sources.

### Verification

Run:

```bash id="u5c9kn"
getent passwd fredrick
```

Expected result in the current environment:

```text id="e8m4qs"
fredrick:x:1000:1002:FREDRICK :/home/fredrick:/bin/bash
```

Account information can differ between systems and can change when an account is modified, so verification should use the current system output.

### Quick Review

**What does `getent` do?**

It retrieves entries from databases configured through the system's Name Service Switch mechanism.

**What does `getent passwd` query?**

The passwd database containing user-account information.

**What does the third field represent?**

The user's UID.

**What does the fourth field represent?**

The user's primary GID.

**What does the sixth field represent?**

The user's home directory.

**What does the seventh field represent?**

The user's configured login shell.

**Observed username:**

```text id="q2v7mc"
fredrick
```

**Observed UID:**

```text id="n6k4rp"
1000
```

**Observed primary GID:**

```text id="s9w3ht"
1002
```

**Observed home directory:**

```text id="c5m8vd"
/home/fredrick
```

**Observed login shell:**

```text id="f7x2qk"
/bin/bash
```
