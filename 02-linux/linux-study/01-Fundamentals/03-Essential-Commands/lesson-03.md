/# Lesson 03 – Essential Commands

## Learning Objectives

By the end of this lesson, I should be able to:

- Explain the purpose of common Linux command-line utilities.
- Navigate the filesystem using `pwd`, `ls`, and `cd`.
- Create, copy, move, rename, and remove files and directories.
- Inspect file contents and metadata.
- Search for files and text from the command line.
- Understand basic text-processing commands.
- Interpret command output accurately.
- Use command options appropriately.
- Apply essential commands safely in Linux environments.
- Explain why essential command-line skills matter in cybersecurity.
## 1. `pwd` — Print Working Directory

The `pwd` command displays the absolute path of the directory you are currently working in.

### Syntax

pwd

### Example

pwd

Example output:

/home/fredrick/Cybersecurity-projects/01-Linux/01-Fundamentals/03-Essential-Commands

### Why It Matters

Knowing your current location is essential when working with files and directories.

A wrong working directory can cause you to:

- Read the wrong file.
- Create files in the wrong location.
- Modify the wrong data.
- Run commands against an unintended path.

### Practical Verification

Run:

pwd

Then compare the output with the directory shown in your shell prompt.

### Security Relevance

In cybersecurity work, knowing the current working directory helps prevent mistakes when analyzing files, collecting evidence, running scripts, or performing administrative tasks.

`pwd` is a simple command, but it provides important context before executing filesystem operations.
## 2. `ls` — List Directory Contents

The `ls` command lists files and directories in a specified location.

When used without an argument, `ls` lists the contents of the current working directory.

### Syntax

ls

### Common Options

`ls -l` displays detailed information such as permissions, ownership, size, and modification time.

`ls -a` includes hidden files and directories.

`ls -h` makes file sizes easier for humans to read when used with `-l`.

These options can be combined:

ls -lah

### Why It Matters

Listing directory contents helps you understand what exists in a filesystem location before interacting with files.

The long format can reveal:

- File permissions.
- File ownership.
- File size.
- Modification time.
- File and directory names.

### Practical Verification

Run:

ls

Then run:

ls -l

Then:

ls -la

Compare the information displayed by each command.

### Security Relevance

In cybersecurity work, `ls` is frequently useful when examining directories, reviewing permissions, identifying files, and understanding the contents of a system.

The `-l` option is particularly useful because permissions and ownership can provide important security context.
## 3. `cd` — Change Directory

The `cd` command changes the shell's current working directory.

Unlike most external commands, `cd` is normally a shell builtin because it must change the working directory of the current shell process.

### Syntax

cd DIRECTORY

### Common Uses

`cd /path/to/directory` changes to an absolute path.

`cd directory` changes to a directory relative to the current location.

`cd ..` moves to the parent directory.

`cd ~` moves to the user's home directory.

`cd -` returns to the previous working directory.

### Why It Matters

Filesystem operations are affected by the current working directory.

Understanding `cd` helps you navigate deliberately rather than relying on assumptions about where a command will operate.

### Practical Verification

First run:

pwd

Then:

cd ..

Run:

pwd

Then return to the Essential Commands directory using:

cd ~/Cybersecurity-projects/01-Linux/01-Fundamentals/03-Essential-Commands

Finally verify:

pwd

### Security Relevance

Incorrect directory navigation can lead to examining, modifying, copying, or deleting the wrong files.

In cybersecurity work, deliberate navigation is therefore an important safety habit, especially when working with evidence, system files, scripts, and security-testing labs.
## 4. `mkdir` — Make Directories

The `mkdir` command creates new directories.

### Syntax

mkdir DIRECTORY

### Common Options

`mkdir -p` creates parent directories when they do not already exist.

For example:

mkdir -p project/docs/research

This can create the entire directory path when `project`, `docs`, or `research` does not yet exist.

### Why It Matters

Directories provide structure for organizing files and projects.

A well-organized filesystem makes it easier to:

- Locate files.
- Separate different types of data.
- Manage permissions.
- Automate tasks.
- Maintain clean project structures.

### Practical Verification

Create a temporary directory inside the current lesson directory:

mkdir lesson03-test

Then verify it:

ls -ld lesson03-test

The output should show that `lesson03-test` is a directory.

You can also verify its type with:

file lesson03-test

### Cleanup

Because this directory is only for practice, remove it after verification:

rmdir lesson03-test

Then confirm that it is gone:

ls -ld lesson03-test

The final command should report that the directory does not exist.

### Security Relevance

Directory organization matters when separating logs, evidence, scripts, configuration files, research data, and laboratory environments.

Using predictable directory structures also makes automation and security analysis easier.
## 5. `touch` — Create Files and Update Timestamps

The `touch` command creates an empty file when the specified file does not already exist.

If the file already exists, `touch` normally updates its access and modification timestamps.

### Syntax

touch FILE

### Example

touch example.txt

This creates `example.txt` if it does not already exist.

### Why It Matters

Creating files from the command line is a fundamental Linux skill.

Files can be used for:

- Notes.
- Configuration.
- Logs.
- Scripts.
- Source code.
- Research data.
- Documentation.

The timestamp behavior of `touch` is also important because Linux filesystems maintain metadata about when files were accessed or modified.

### Practical Verification

Create a temporary file:

touch lesson03-test.txt

Verify that it exists:

ls -l lesson03-test.txt

Check its file type:

file lesson03-test.txt

Inspect its metadata:

stat lesson03-test.txt

### Cleanup

Remove the temporary file after verification:

rm lesson03-test.txt

Then verify that it no longer exists:

ls -l lesson03-test.txt

The command should report that the file does not exist.

### Security Relevance

File timestamps can provide useful context during system administration, troubleshooting, and forensic analysis.

However, timestamps should not automatically be treated as proof of when an event occurred. They are filesystem metadata and must be interpreted alongside other evidence.

Understanding `touch` also helps explain how ordinary file operations can change filesystem metadata.
## 6. `cp` — Copy Files and Directories

The `cp` command copies files and directories from one location to another.

### Syntax

cp SOURCE DESTINATION

### Example

Create a temporary source file:

touch source.txt

Copy it:

cp source.txt copy.txt

The original file remains, and `copy.txt` is created as a separate file.

### Common Options

`cp -i` asks for confirmation before overwriting an existing destination.

`cp -v` displays what is being copied.

`cp -r` copies directories recursively, including their contents.

For example:

cp -r source-directory destination-directory

### Why It Matters

Copying files is useful for:

- Creating backups.
- Duplicating project files.
- Preserving working copies.
- Organizing data.
- Preparing files for analysis.

### Practical Verification

Create a temporary source file:

touch lesson03-source.txt

Copy it:

cp lesson03-source.txt lesson03-copy.txt

Verify both files:

ls -l lesson03-source.txt lesson03-copy.txt

Then compare their file information:

stat lesson03-source.txt
stat lesson03-copy.txt

The two files should be separate filesystem objects.

### Cleanup

Remove the temporary files:

rm lesson03-source.txt lesson03-copy.txt

Verify:

ls -l lesson03-source.txt lesson03-copy.txt

The files should no longer exist.

### Security Relevance

Copying files is common during system administration, backups, incident-response preparation, and controlled security analysis.

When working with important evidence or configuration files, creating a separate working copy can help preserve the original data. Care must still be taken to maintain appropriate permissions and file integrity.
## 7. `mv` — Move and Rename Files

The `mv` command moves files or directories from one location to another.

It is also commonly used to rename files and directories.

### Syntax

mv SOURCE DESTINATION

### Rename Example

Create a temporary file:

touch old-name.txt

Rename it:

mv old-name.txt new-name.txt

The file now has the name `new-name.txt`.

### Move Example

Create a temporary directory:

mkdir lesson03-destination

Move the file into it:

mv new-name.txt lesson03-destination/

The file is now located inside `lesson03-destination`.

### Common Options

`mv -i` asks for confirmation before overwriting an existing destination.

`mv -v` displays the operation being performed.

### Why It Matters

Moving and renaming files helps maintain organized filesystem structures.

It is useful for:

- Organizing project files.
- Renaming documents.
- Reorganizing directories.
- Managing configuration files.
- Maintaining clean research environments.

### Practical Verification

Verify the temporary directory:

ls -ld lesson03-destination

Then verify its contents:

ls -l lesson03-destination

The file `new-name.txt` should be inside the directory.

### Cleanup

Remove the temporary directory and its contents:

rm -r lesson03-destination

Then verify:

ls -ld lesson03-destination

The directory should no longer exist.

### Security Relevance

Moving or renaming files can change how applications, scripts, and administrators locate data.

In security work, understanding `mv` is important when organizing evidence, managing configuration files, or restructuring controlled laboratory environments.

Because `mv` can overwrite an existing destination, using options such as `-i` can provide an additional safety check.
## 8. `rm` — Remove Files and Directories

The `rm` command removes files and, with appropriate options, directories.

Unlike moving a file to a desktop trash/recycle system, normal `rm` operations do not provide a simple undo mechanism.

### Syntax

rm FILE

### Common Options

`rm -i` asks for confirmation before removing each file.

`rm -v` displays what is being removed.

`rm -r` removes directories recursively, including their contents.

### Why It Matters

Removing unnecessary files helps maintain an organized filesystem.

However, `rm` must be used carefully because an incorrect path can result in unintended data loss.

### Practical Verification

Create a temporary file:

touch lesson03-remove.txt

Verify that it exists:

ls -l lesson03-remove.txt

Remove it interactively:

rm -i lesson03-remove.txt

When prompted for confirmation, answer `y`.

Then verify:

ls -l lesson03-remove.txt

The command should report that the file does not exist.

### Removing a Directory

Create a temporary directory:

mkdir lesson03-remove-dir

Verify it:

ls -ld lesson03-remove-dir

An empty directory can be removed with:

rmdir lesson03-remove-dir

For directories containing files, `rm -r` can remove the directory and its contents. This should only be used when the target has been carefully verified.

### Security Relevance

Deletion is an important filesystem operation in system administration, incident response, and forensic work.

From a security perspective, `rm` is especially important because accidental deletion can destroy useful data or evidence.

Before using a recursive or broad removal command, verify:

- The current working directory.
- The exact target path.
- The files or directories that will be affected.
- Whether the data needs to be preserved.

Using `pwd` and `ls` before destructive operations is a useful safety habit.

## 9. `cat` — Display File Contents

### Purpose

The `cat` command is commonly used to display the contents of a text file directly in the terminal.

The name comes from "concatenate" because `cat` can also combine the contents of multiple files.

### Basic Syntax

cat filename

Example:

cat notes.txt

This reads the contents of `notes.txt` and prints them to standard output.

### Common Uses

Display one file:

cat notes.txt

Display multiple files:

cat file1.txt file2.txt

Number the output lines:

cat -n notes.txt

Show non-printing characters:

cat -A notes.txt

The `-n` option is useful when line numbers help you identify a particular line.

### Practical Verification

Create a temporary file:

touch lesson03-cat.txt

Add some text:

printf '%s\n' 'Linux command practice' 'Project 01' > lesson03-cat.txt

Display it:

cat lesson03-cat.txt

Expected output:

Linux command practice
Project 01

Inspect the file with line numbers:

cat -n lesson03-cat.txt

Expected output:

1  Linux command practice
2  Project 01

Clean up:

rm lesson03-cat.txt

### Important Safety Note

`cat` normally reads and displays data; it does not modify the file simply by being used this way.

However, shell redirection changes the situation.

For example:

cat notes.txt > copy.txt

The `>` operator redirects the output of `cat` into `copy.txt`.

Redirection is therefore an important concept to understand separately from the `cat` command itself.

### Security Relevance

`cat` is useful when:

- Inspecting configuration files.
- Reading logs and notes.
- Reviewing scripts.
- Examining command output saved to files.
- Investigating files during system administration or incident response.

A security analyst may use `cat` to quickly inspect a small text file before deciding whether a larger or more specialized tool is appropriate.

### Practical Principle

Use `cat` when a file is small enough to inspect comfortably in the terminal.

For larger files, tools such as `less`, `head`, or `tail` are often more appropriate.

### Completion Check

I should be able to:

- Display a file's contents with `cat`.
- Display multiple files.
- Use `cat -n` to show line numbers.
- Understand that `cat` displays data while redirection determines where output goes.
- Choose another inspection tool when a file is too large for comfortable terminal output.
## 10. `less` — Inspect Files Interactively

### Purpose

The `less` command is used to view text files one screen at a time.

Unlike `cat`, which normally prints the entire file immediately, `less` provides an interactive viewer that is more suitable for larger files.

### Basic Syntax

less filename

Example:

less notes.txt

When `less` opens a file, the terminal becomes an interactive viewing area.

### Useful Controls

Inside `less`:

Space
Move forward one screen.

b
Move backward one screen.

Up Arrow
Move up one line.

Down Arrow
Move down one line.

g
Go to the beginning of the file.

G
Go to the end of the file.

/word
Search forward for a word or pattern.

n
Move to the next search result.

q
Quit `less`.

### Practical Verification

Create a temporary file containing several lines:

printf '%s\n' 'Line 1' 'Line 2' 'Line 3' 'Line 4' 'Line 5' > lesson03-less.txt

Open it:

less lesson03-less.txt

Practice:

- Move forward and backward.
- Press `g` to reach the beginning.
- Press `G` to reach the end.
- Search for a word using `/`.
- Press `q` to exit.

After exiting, remove the temporary file:

rm lesson03-less.txt

### `cat` vs `less`

`cat` is useful when:

- The file is small.
- You want the contents printed directly.
- You want to combine or redirect file contents.

`less` is useful when:

- The file is large.
- You need to move through the file interactively.
- You need to search while reading.
- Printing the entire file at once would be inconvenient.

### Security Relevance

`less` is particularly useful when examining:

- Large log files.
- Configuration files.
- System information.
- Source code.
- Security reports.
- Incident-response evidence.

When investigating a large text file, an interactive viewer can reduce the risk of losing track of important information in a large terminal output.

### Practical Principle

Choose an inspection tool based on the size and purpose of the file.

Do not automatically use `cat` for every file.

### Completion Check

I should be able to:

- Open a file with `less`.
- Navigate through a file.
- Search within a file.
- Reach the beginning and end of a file.
- Exit `less` safely with `q`.
- Explain when `less` is more appropriate than `cat`.
## 11. `head` and `tail` — Inspect File Sections

### Purpose

The `head` and `tail` commands display selected portions of a text file.

`head` is normally used to inspect the beginning of a file.

`tail` is normally used to inspect the end of a file.

These commands are especially useful when a file is too large to read completely.

### Basic Syntax

head filename

tail filename

Example:

head notes.txt

tail notes.txt

By default, both commands normally display the first or last 10 lines.

### Display a Specific Number of Lines

Use `-n` to specify how many lines to display.

Display the first 5 lines:

head -n 5 notes.txt

Display the last 5 lines:

tail -n 5 notes.txt

### Practical Verification

Create a temporary file containing several numbered lines:

printf '%s\n' 'Line 1' 'Line 2' 'Line 3' 'Line 4' 'Line 5' 'Line 6' 'Line 7' 'Line 8' 'Line 9' 'Line 10' > lesson03-sections.txt

Display the beginning:

head lesson03-sections.txt

Display the end:

tail lesson03-sections.txt

Display only the first 3 lines:

head -n 3 lesson03-sections.txt

Expected output:

Line 1
Line 2
Line 3

Display only the last 3 lines:

tail -n 3 lesson03-sections.txt

Expected output:

Line 8
Line 9
Line 10

Clean up:

rm lesson03-sections.txt

### `head` vs `tail`

`head` is useful when you want to inspect:

* The beginning of a configuration file.
* The first records in a dataset.
* The beginning of command output.
* The structure or format of a text file.

`tail` is useful when you want to inspect:

* The most recent entries in a log.
* The end of a configuration or text file.
* The final results of a command.
* Recent events recorded in a file.

### Following a Changing File

`tail` has an important option called `-f`.

Example:

tail -f application.log

This keeps the command running and displays new lines added to the file as they appear.

Press Ctrl+C to stop following the file.

This is particularly useful for monitoring logs during system administration and troubleshooting.

### Security Relevance

`head` and `tail` are useful during security analysis because they allow an analyst to inspect portions of large files without immediately printing everything to the terminal.

For example:

tail -n 20 system.log

can show the most recent 20 lines of a log.

This can help when troubleshooting a service or examining recent system activity in an authorized environment.

### Practical Principle

Use the smallest amount of data necessary for the task.

For a large file:

* Use `head` when the beginning is relevant.
* Use `tail` when the end is relevant.
* Use `less` when interactive exploration is needed.
* Use specialized tools when the file requires structured analysis.

### Completion Check

I should be able to:

* Explain the difference between `head` and `tail`.
* Display the beginning of a file.
* Display the end of a file.
* Select a specific number of lines with `-n`.
* Explain what `tail -f` does.
* Stop `tail -f` with Ctrl+C.
* Choose between `head`, `tail`, and `less` based on the task.
## 12. `file` — Identify File Types

### Purpose

The `file` command identifies the type of data contained in a file.

It does not simply rely on the filename extension.

This is important because a file can have a misleading or missing extension.

### Basic Syntax

file filename

Example:

file notes.txt

The command examines the contents of the file and reports the type it recognizes.

### Practical Verification

Create a temporary text file:

printf '%s\n' 'This is a Linux practice file.' > lesson03-file.txt

Identify it:

file lesson03-file.txt

The output should identify the file as text or ASCII/UTF-8 text, depending on the contents and system environment.

Inspect the file:

cat lesson03-file.txt

Then remove it:

rm lesson03-file.txt

### Why File Extensions Are Not Enough

A filename such as:

report.txt

suggests that the file is text, but the `.txt` extension alone does not prove what the file actually contains.

Linux does not require a file's contents to match its filename extension.

For example, a file could be renamed without changing its contents.

This means:

file suspicious-name.txt

can provide more useful information about the actual file type than looking only at the filename.

### Useful Examples

Identify several files:

file /etc/passwd

file /bin/ls

file /usr/bin/python3

The results demonstrate that different types of files can exist on the same Linux system.

You may also run:

file *

to inspect the recognized types of entries in the current directory.

Be careful when using wildcard expressions in directories containing many files because the command may produce a large amount of output.

### Security Relevance

`file` is useful in security analysis because filenames and extensions should not automatically be trusted.

It can help when:

* Investigating unfamiliar files.
* Identifying downloaded files.
* Examining files during incident response.
* Checking whether a file appears to contain executable data.
* Investigating files with misleading extensions.
* Determining what type of data a file appears to contain.

This is an identification step, not proof that a file is safe.

A file identified as an executable should not automatically be executed.

### Important Principle

File identification and file safety are different questions.

`file` helps answer:

"What type of data does this file appear to contain?"

It does not answer:

"Is this file trustworthy or safe to execute?"

Additional analysis may be required depending on the situation.

### Completion Check

I should be able to:

* Explain what `file` does.
* Identify a file's apparent type.
* Explain why filename extensions are not sufficient for identification.
* Use `file` on individual files.
* Understand the security value of identifying unfamiliar files.
* Explain the difference between identifying a file and determining whether it is safe.
## 13. `stat` — Inspect File Metadata

### Purpose

The `stat` command displays detailed metadata about a file or directory.

Metadata is information about an object rather than the contents of the object itself.

This can include:

* File type.
* Permissions.
* Owner.
* Group.
* Size.
* Timestamps.
* Inode information.
* Filesystem information.

### Basic Syntax

stat filename

Example:

stat notes.txt

This displays detailed information about `notes.txt`.

### Practical Verification

Create a temporary file:

touch lesson03-stat.txt

Inspect it:

stat lesson03-stat.txt

Pay attention to information such as:

* File type.
* Size.
* Access permissions.
* Owner.
* Group.
* Access time.
* Modification time.
* Change time.

Remove the temporary file:

rm lesson03-stat.txt

### Compact Output

The `-c` option allows a custom output format.

For example:

stat -c '%A %a %U:%G %n' filename

This can display:

* Symbolic permissions.
* Numeric permissions.
* Owner.
* Group.
* Filename.

Example format:

-rw-r--r-- 644 fredrick:fredrick notes.txt

The exact owner and group depend on the system.

### Understanding Permissions with `stat`

`stat` is particularly useful when troubleshooting permission problems.

For example:

stat -c '%A %a %U:%G %n' directory

A result such as:

dr-x------ 500 fredrick:fredrick directory

means the owner has:

* `r` — read/list permission.
* `-` — no write permission.
* `x` — execute/traverse permission.

The numeric value `500` represents:

* `4` — read.
* `0` — no group permissions.
* `0` — no other permissions.

### Real Troubleshooting Example

Earlier in this project, an old practice directory could not initially be removed.

The relevant directory had permissions equivalent to:

dr-x------ 500 fredrick:fredrick access-lab

The important observation was that the owner did not have `w` permission on the directory.

For a directory, write permission controls whether directory entries can generally be created, deleted, or renamed.

We therefore investigated the permissions instead of immediately using elevated privileges.

After confirming the problem, the owner write permission was added with:

chmod u+w access-lab

The directory then showed:

drwx------ 700 fredrick:fredrick access-lab

The directory could subsequently be removed normally.

### Important Lesson

When a Linux operation fails with "Permission denied", do not immediately assume that the file itself is the problem.

Investigate:

* Where the object is located.
* Who owns the object.
* Which permissions are present.
* Whether the relevant parent directory permits the required operation.

`stat` is one of the tools that helps answer these questions.

### Security Relevance

`stat` is useful for:

* Investigating file permissions.
* Examining ownership.
* Reviewing timestamps.
* Troubleshooting access problems.
* Examining filesystem metadata.
* Supporting incident-response investigations.
* Comparing metadata before and after an authorized change.

Timestamps can provide useful clues during investigations, but they should not automatically be treated as proof of when an event occurred.

### Practical Principle

Use `stat` when ordinary directory listings do not provide enough metadata to understand a file or directory.

A good troubleshooting workflow is:

pwd

ls -ld object

stat object

Then investigate the relevant ownership, permissions, and filesystem context.

### Completion Check

I should be able to:

* Explain what file metadata is.
* Use `stat` to inspect a file or directory.
* Interpret basic permission information from `stat`.
* Understand symbolic and numeric permission representations.
* Identify ownership and group information.
* Explain why directory permissions matter when deleting or modifying entries.
* Use `stat` as part of a permission troubleshooting workflow.
## 14. `wc` — Count Lines, Words, and Bytes

### Purpose

The `wc` command counts information about the contents of files or other input.

The name `wc` comes from "word count", although the command can count more than words.

It can report:

* Lines.
* Words.
* Bytes.
* Characters.

This makes `wc` useful when quickly measuring or summarizing text data.

### Basic Syntax

wc filename

Example:

wc notes.txt

By default, `wc` normally displays the number of lines, words, bytes, and the filename.

### Common Options

Count lines:

wc -l notes.txt

Count words:

wc -w notes.txt

Count bytes:

wc -c notes.txt

Count characters:

wc -m notes.txt

These options allow you to request only the measurement that is relevant to your task.

### Practical Verification

Create a temporary file:

printf '%s\n' 'Linux command practice' 'Project 01' 'Essential commands' > lesson03-wc.txt

Count lines:

wc -l lesson03-wc.txt

Expected result:

3 lesson03-wc.txt

Count words:

wc -w lesson03-wc.txt

The exact number can be verified from the contents of the file.

Count bytes:

wc -c lesson03-wc.txt

The exact byte count depends on the characters and line endings in the file.

Count characters:

wc -m lesson03-wc.txt

Remove the temporary file:

rm lesson03-wc.txt

### Understanding Lines and Words

Consider this file:

First line
Second line
Third line

There are:

* 3 lines.
* 6 words.

The line count depends on newline characters.

The word count depends on how the `wc` implementation interprets whitespace-separated words.

Therefore, `wc` provides useful measurements, but you should understand what is actually being counted.

### Using `wc` with Other Commands

`wc` can also receive input through a pipeline.

For example:

printf '%s\n' apple banana orange | wc -l

This counts the number of input lines.

A pipeline allows the output of one command to become the input of another command.

This is an important foundation for Linux command-line automation and text processing.

### Multiple Files

You can provide multiple files:

wc file1.txt file2.txt

The output will contain measurements for each file and normally a total.

This can be useful when comparing or summarizing several text files.

### Security Relevance

`wc` can be useful during security analysis and system administration when you need quick measurements of text data.

For example, it can help with:

* Estimating the size of a log.
* Counting lines in a configuration file.
* Measuring command output.
* Comparing text files.
* Quickly determining how much data needs further inspection.

For example:

wc -l application.log

can show how many lines are present in a log file.

This does not analyze the meaning of the log entries; it simply provides a useful measurement.

### Important Principle

Counting data is different from understanding data.

For example:

wc -l log.txt

can tell you how many lines exist, but it does not tell you how many security events occurred.

The structure of the data must always be considered.

### Practical Principle

Use `wc` when you need a quick quantitative measurement of text.

Combine it with other commands when you need deeper analysis.

For example:

grep "ERROR" application.log | wc -l

can count lines containing the specified text.

This introduces an important command-line pattern:

search first, then count the results.

### Completion Check

I should be able to:

* Explain the purpose of `wc`.
* Count lines with `wc -l`.
* Count words with `wc -w`.
* Count bytes with `wc -c`.
* Count characters with `wc -m`.
* Use `wc` with multiple files.
* Use `wc` with piped input.
* Explain why counting data is different from analyzing its meaning.
nano lesson-03.md


## 15. `sort` and `uniq` — Organize and Deduplicate Text

### Purpose

The `sort` command organizes lines of text into a specified order.

The `uniq` command removes or reports repeated adjacent lines.

Together, these commands are useful for organizing text and identifying duplicate entries.

### Basic Syntax

```text
sort filename
```

Example:

```text
sort names.txt
```

By default, `sort` normally arranges lines in lexicographical order.

For example:

```text
banana
apple
orange
```

can become:

```text
apple
banana
orange
```

### Reverse Sorting

The `-r` option reverses the sorting order.

Example:

```text
sort -r names.txt
```

This produces the reverse of the normal sorting order.

### Numeric Sorting

The `-n` option performs numeric sorting.

For example:

```text
sort -n numbers.txt
```

This is useful when lines contain numerical values.

Without numeric sorting, values may be compared as text rather than as numbers.

### Practical Verification

Create a temporary file containing unsorted values:

```text
printf '%s\n' banana apple orange grape apple > lesson03-sort.txt
```

Display the original contents:

```text
cat lesson03-sort.txt
```

Sort the contents:

```text
sort lesson03-sort.txt
```

Expected output:

```text
apple
apple
banana
grape
orange
```

Notice that sorting does not modify the original file unless its output is redirected back into a file.

### Understanding `uniq`

The `uniq` command detects repeated adjacent lines.

Example:

```text
uniq lesson03-sort.txt
```

An important detail is that `uniq` works on adjacent duplicates.

For example:

```text
apple
banana
apple
```

contains two occurrences of `apple`, but they are not adjacent.

`uniq` will therefore not treat them as one consecutive duplicate group.

### Sorting Before `uniq`

A common pattern is:

```text
sort lesson03-sort.txt | uniq
```

The `sort` command places identical lines next to each other.

Then `uniq` can remove repeated adjacent lines.

Expected output:

```text
apple
banana
grape
orange
```

This is a useful example of combining simple Linux commands through a pipeline.

### Count Duplicate Entries

The `-c` option of `uniq` counts consecutive occurrences.

Example:

```text
sort lesson03-sort.txt | uniq -c
```

The output will show each unique line together with its count.

The exact formatting may vary slightly depending on the system.

### Practical Verification

Run:

```text
sort lesson03-sort.txt | uniq
```

Then run:

```text
sort lesson03-sort.txt | uniq -c
```

Compare the results.

Finally remove the temporary file:

```text
rm lesson03-sort.txt
```

### Security Relevance

`sort` and `uniq` can help organize text during security analysis.

They can be useful for:

* Organizing lists of observations.
* Identifying repeated log entries.
* Counting repeated values.
* Preparing command output for further analysis.
* Reducing duplicate information before manual inspection.

For example:

```text
sort events.txt | uniq -c
```

can help identify repeated lines in a text dataset.

However, duplicate text does not necessarily represent duplicate real-world events. Always understand the structure and meaning of the data before drawing conclusions.

### Important Principle

`uniq` removes consecutive duplicate lines, not arbitrary duplicates throughout an unsorted file.

Therefore:

```text
uniq file.txt
```

is not always equivalent to:

```text
sort file.txt | uniq
```

The second form first organizes the data so identical lines become adjacent.

### Practical Principle

Simple commands become more powerful when combined.

For example:

```text
sort data.txt | uniq -c | sort -nr
```

can organize repeated values by frequency.

Each command performs one focused operation, while the pipeline combines their results.

### Completion Check

I should be able to:

* Explain what `sort` does.
* Sort text normally and in reverse order.
* Perform numeric sorting with `sort -n`.
* Explain what `uniq` does.
* Explain why `uniq` works on adjacent duplicate lines.
* Use `sort | uniq` to deduplicate sorted text.
* Use `uniq -c` to count repeated entries.
* Explain how pipelines combine simple commands.
## 16. `grep` — Search Text for Patterns

### Purpose

The `grep` command searches text for lines that match a specified pattern.

It is one of the most useful command-line tools for examining text, logs, configuration files, command output, and other structured information.

### Basic Syntax

```text
grep "pattern" filename
```

Example:

```text
grep "error" application.log
```

This searches `application.log` and displays lines containing the specified pattern.

### Simple Text Search

Create a temporary file:

```text
printf '%s\n' "INFO system started" "ERROR connection failed" "INFO user logged in" "WARNING disk usage high" > lesson03-grep.txt
```

Display it:

```text
cat lesson03-grep.txt
```

Search for `ERROR`:

```text
grep "ERROR" lesson03-grep.txt
```

Expected result:

```text
ERROR connection failed
```

### Case-Insensitive Search

The `-i` option makes the search case-insensitive.

Example:

```text
grep -i "error" lesson03-grep.txt
```

This can match:

```text
ERROR
Error
error
```

depending on the contents of the file.

### Show Matching Line Numbers

The `-n` option displays the line number alongside each matching line.

Example:

```text
grep -n "INFO" lesson03-grep.txt
```

This is useful when you need to locate matching information within a larger file.

### Invert the Search

The `-v` option displays lines that do **not** match the specified pattern.

Example:

```text
grep -v "INFO" lesson03-grep.txt
```

This can be useful when filtering out known or uninteresting lines.

### Count Matching Lines

The `-c` option counts matching lines instead of displaying them.

Example:

```text
grep -c "INFO" lesson03-grep.txt
```

This returns the number of lines containing the pattern.

Remember that this counts matching **lines**, not necessarily the total number of times the pattern appears.

### Search Multiple Files

`grep` can search more than one file.

Example:

```text
grep "ERROR" file1.txt file2.txt
```

When appropriate, `grep` identifies which file contains each match.

### Search Recursively

The `-r` option searches through files in subdirectories.

Example:

```text
grep -r "TODO" project/
```

This can help locate matching text across a directory tree.

Use recursive searches carefully on large directory trees because they may inspect many files.

### Security Relevance

`grep` is extremely useful during defensive security analysis and controlled laboratory work.

It can help with:

* Searching application logs.
* Finding configuration values.
* Locating error messages.
* Filtering command output.
* Investigating repeated events.
* Identifying relevant lines in large text files.
* Preparing information for further analysis.

For example:

```text
grep "ERROR" application.log
```

can quickly identify lines containing an error marker.

A more powerful pattern is:

```text
grep "ERROR" application.log | wc -l
```

which searches first and then counts the matching lines.

### Important Principle

`grep` searches for matching patterns; it does not automatically understand the meaning of the data.

For example:

```text
grep "failed" authentication.log
```

finds lines containing `failed`, but additional context may be required to determine what actually happened.

Always interpret search results in the context of the underlying data.

### Practical Principle

Use `grep` to reduce a large amount of text to the lines that deserve closer inspection.

Then combine it with other commands when appropriate.

For example:

```text
grep "ERROR" application.log | sort | uniq -c
```

can organize and count repeated matching lines.

### Completion Check

I should be able to:

* Explain what `grep` does.
* Search a file for a text pattern.
* Use `grep -i` for case-insensitive searches.
* Use `grep -n` to display matching line numbers.
* Use `grep -v` to exclude matching lines.
* Use `grep -c` to count matching lines.
* Search multiple files.
* Explain the purpose of recursive searching with `grep -r`.
* Combine `grep` with pipelines and other commands.
* Explain why matching text is not the same as understanding the underlying event.


## 17. `find` — Locate Files and Directories

### Purpose

The `find` command searches for files and directories within a specified location.

Unlike commands that simply display directory contents, `find` can search based on properties such as:

* Name.
* File type.
* Permissions.
* Ownership.
* Modification time.
* Other filesystem attributes.

`find` is therefore an important tool for filesystem administration, troubleshooting, and security analysis.

### Basic Syntax

```text
find path condition
```

A simple example is:

```text
find . -name "notes.txt"
```

This searches from the current directory and looks for objects named `notes.txt`.

The `.` means the current directory.

### Search by Name

The `-name` option searches for a name using a case-sensitive pattern.

Example:

```text
find . -name "report.txt"
```

This searches the current directory and its descendants for objects named exactly `report.txt`.

Wildcards can also be used.

For example:

```text
find . -name "*.log"
```

can locate files whose names end in `.log`.

### Case-Insensitive Name Search

The `-iname` option performs a case-insensitive name search.

Example:

```text
find . -iname "*.log"
```

This can match names such as:

```text
system.log
SYSTEM.LOG
System.Log
```

depending on the actual filenames.

### Search for Files Only

The `-type f` condition restricts the search to regular files.

Example:

```text
find . -type f -name "*.txt"
```

This searches for regular files ending in `.txt`.

### Search for Directories Only

The `-type d` condition restricts the search to directories.

Example:

```text
find . -type d -name "logs"
```

This searches for directories named `logs`.

### Combining Conditions

`find` can combine conditions to make searches more precise.

For example:

```text
find . -type f -name "*.log"
```

means:

* Start in the current directory.
* Look only for regular files.
* Match names ending in `.log`.

This is more precise than simply searching for a filename pattern.

### Search Within a Specific Directory

The starting path does not have to be `.`.

For example:

```text
find /tmp -type f -name "*.log"
```

searches under `/tmp`.

When working with real systems, choose the search location deliberately. Searching an entire filesystem can produce a large amount of output and may take significantly longer than searching a specific directory.

### Practical Verification

Create a small temporary directory structure:

```text
mkdir -p lesson03-find-lab/logs lesson03-find-lab/docs
```

Create some temporary files:

```text
printf '%s\n' "test log" > lesson03-find-lab/logs/system.log
```

```text
printf '%s\n' "test error log" > lesson03-find-lab/logs/error.log
```

```text
printf '%s\n' "test document" > lesson03-find-lab/docs/notes.txt
```

Now search for the log files:

```text
find lesson03-find-lab -type f -name "*.log"
```

The results should include:

```text
lesson03-find-lab/logs/system.log
lesson03-find-lab/logs/error.log
```

### Search for Directories

Run:

```text
find lesson03-find-lab -type d
```

This should display the temporary lab directory and its subdirectories.

### Search by Exact Filename

Run:

```text
find lesson03-find-lab -name "notes.txt"
```

This should locate:

```text
lesson03-find-lab/docs/notes.txt
```

### Search by File Type

Run:

```text
find lesson03-find-lab -type f
```

This should display all regular files in the temporary lab.

### Understanding Recursive Searching

`find` searches through the specified starting directory and its descendants.

For example:

```text
find lesson03-find-lab -type f
```

searches:

```text
lesson03-find-lab/
├── logs/
│   ├── system.log
│   └── error.log
└── docs/
    └── notes.txt
```

The search therefore includes files inside the subdirectories.

### Search by Modification Time

`find` can also search based on file age.

For example:

```text
find . -type f -mtime -1
```

looks for regular files modified within approximately the last day.

Time-based searches are useful for administration and investigation, but their interpretation depends on the filesystem timestamps and the exact conditions used.

### Search by Permissions

`find` can search for particular permission patterns.

For example:

```text
find . -type f -perm 600
```

searches for regular files whose permissions exactly match `600`.

Permission searches should be interpreted carefully because different `find` permission expressions have different meanings.

### Search by User

`find` can search for objects owned by a particular user.

Example:

```text
find . -type f -user fredrick
```

This searches for regular files owned by the specified user.

When using such searches on systems you administer or are authorized to investigate, make sure you understand the ownership information before drawing conclusions.

### Security Relevance

`find` is highly useful for defensive system administration and authorized security analysis.

It can help with:

* Locating configuration files.
* Finding log files.
* Identifying files in unexpected directories.
* Auditing filesystem contents.
* Investigating recently modified files.
* Reviewing ownership and permissions.
* Finding files matching known criteria.
* Supporting controlled security investigations.

For example:

```text
find /var/log -type f -name "*.log"
```

can locate log files under a specific directory.

Another example:

```text
find . -type f -mtime -1
```

can help identify files modified recently within a controlled investigation.

### Important Principle

`find` searches filesystem objects based on the conditions you specify.

It does not automatically determine whether a file is safe, malicious, important, or suspicious.

For example:

```text
find . -name "*.sh"
```

only tells you that matching files exist.

You must inspect their contents, ownership, permissions, timestamps, and context before making conclusions.

### Practical Principle

Start with the **narrowest reasonable search location and conditions**.

For example, this:

```text
find lesson03-find-lab -type f -name "*.log"
```

is more controlled than immediately searching a very large filesystem tree.

Narrow searches are easier to understand, faster to verify, and less likely to produce overwhelming output.

### Completion Check

I should be able to:

* Explain what `find` does.
* Search from a specified starting directory.
* Search by filename with `-name`.
* Perform case-insensitive name searches with `-iname`.
* Restrict searches to files with `-type f`.
* Restrict searches to directories with `-type d`.
* Combine search conditions.
* Search based on modification time.
* Search based on permissions.
* Search based on ownership.
* Explain why the search location matters.
* Explain why finding a file does not automatically determine its meaning or safety.
* Use `find` safely within a controlled filesystem environment.
## 18. `du` and `df` — Disk Usage and Filesystem Space

### Purpose

Linux provides two important commands for understanding storage:

* `du` — estimates how much disk space files and directories use.
* `df` — reports available and used space on mounted filesystems.

These commands answer different questions.

### `du` — Disk Usage

Basic syntax:

```bash
du [options] [path]
```

Example:

```bash
du .
```

This reports disk usage for the current directory and its contents.

Useful options include:

```bash
du -h .
```

Human-readable sizes such as KB, MB, and GB.

```bash
du -sh .
```

Show a summarized total for the specified directory.

```bash
du -sh *
```

Show the summarized size of each item in the current directory.

### `df` — Filesystem Space

Basic syntax:

```bash
df [options] [filesystem]
```

Example:

```bash
df
```

This displays filesystem space usage.

For human-readable output:

```bash
df -h
```

Typical information includes:

* Filesystem
* Total size
* Used space
* Available space
* Percentage used
* Mount point

### `du` vs `df`

The distinction is important:

```text
du → How much space are these files/directories using?

df → How much space is available on the filesystem?
```

For example, if a filesystem is nearly full, `df -h` helps identify the overall storage situation, while `du -sh` can help identify which directories are consuming space.

### Practical Verification

Check the current directory:

```bash
du -sh .
```

Check filesystem space:

```bash
df -h .
```

The two commands provide different information and should not be treated as interchangeable.

### Security Relevance

Disk-usage commands are useful in system administration and security investigations.

Examples include:

* Identifying unexpectedly large directories.
* Investigating sudden storage consumption.
* Checking whether logs are consuming excessive space.
* Looking for unusually large files during an investigation.
* Monitoring systems where low disk space could affect availability.
* Understanding where data is stored before performing further analysis.

A large directory is not automatically suspicious. Size is an observation that should be combined with other evidence such as timestamps, ownership, permissions, filenames, and file contents.

### Practical Principle

Do not assume that `du` and `df` measure the same thing.

Use:

```bash
du
```

when investigating **directory/file usage**.

Use:

```bash
df
```

when investigating **filesystem capacity and availability**.

### Completion Check

I should be able to:

* Explain the difference between `du` and `df`.
* Use `du -h` for human-readable directory usage.
* Use `du -sh` for a summarized directory size.
* Use `df -h` for human-readable filesystem information.
* Explain why both commands are useful during troubleshooting and security investigations.


## 19. `echo` and `printf` — Display Text and Variables

### Purpose

`echo` and `printf` are shell commands used to produce text output.

They are especially useful for:

* displaying information
* working with variables
* building command output
* testing shell behavior
* writing Bash scripts
* generating structured text

### `echo`

Basic syntax:

echo [options] [text]

Examples:

echo "Hello, Linux"
echo "$HOME"
echo "$PATH"

`echo` expands variables when they are inside double quotes.

For example:

echo "$HOME"

displays the value stored in the `HOME` variable.

Single quotes prevent variable expansion:

echo '$HOME'

This displays the literal text:

$HOME

### `printf`

`printf` provides more predictable and controlled formatting than `echo`.

Basic syntax:

printf 'format' [arguments]

Example:

printf '%s\n' "Hello, Linux"

Here:

* `%s` represents a string.
* `\n` represents a newline.

Another example:

printf 'User: %s\n' "$USER"

This produces formatted output containing the current username.

### `echo` vs `printf`

`echo` is convenient for simple output.

`printf` is preferred when precise formatting is important, especially in shell scripts.

For example:

echo "Name: $USER"

and:

printf 'Name: %s\n' "$USER"

both display the username, but `printf` gives more explicit control over formatting.

### Variables

These commands are commonly used with shell variables.

Examples:

echo "$HOME"
echo "$SHELL"
echo "$USER"

printf 'Home: %s\n' "$HOME"
printf 'Shell: %s\n' "$SHELL"
printf 'User: %s\n' "$USER"

Quoting variable expansions is a good habit because it prevents unintended word splitting and preserves the value as one argument.

### Practical Verification

Check simple output:

echo "Linux"
printf '%s\n' "Linux"

Check variables:

echo "$HOME"
printf 'HOME=%s\n' "$HOME"

Compare quoted and unquoted variable expansion:

echo "$HOME"
echo '$HOME'

### Security Relevance

`echo` and `printf` are simple commands, but they are important in cybersecurity because shell scripts frequently use them to:

* display diagnostic information
* construct reports
* process command output
* record findings
* generate configuration or text data
* inspect environment variables
* automate administrative tasks

Understanding quoting and variable expansion is particularly important when writing security automation.

### Practical Principle

Use `echo` for straightforward human-readable output.

Prefer `printf` when predictable formatting, scripting, or structured output matters.

Always understand whether a variable is being expanded or displayed literally.

### Completion Check

I should be able to:

* explain the purpose of `echo`
* explain the purpose of `printf`
* display text with both commands
* display shell variables
* explain single vs double quotes
* explain why `printf` is useful in scripts
* use quoted variables safely


## 20. `history` — Review Shell Command History

### Purpose

The `history` command displays commands previously entered into the current shell's command history.

It is useful for:

* reviewing commands
* repeating previous commands
* troubleshooting
* reconstructing recent work
* learning from previous command usage
* reviewing shell activity during administration and labs

### Basic Usage

Display recent commands:

history

Display a specific number of recent commands:

history 10

This shows the most recent 10 history entries.

### Searching History

History can be combined with other commands.

For example:

history | tail -10

This displays the end of the history output.

Another useful approach is:

history | grep "grep"

This searches displayed history entries for commands containing a particular pattern.

### Reusing Commands

Bash provides several ways to reuse previous commands.

The Up Arrow can recall previous commands interactively.

History expansion can also reference previous commands. For example:

!!

refers to the previous command.

Because history expansion can execute a previous command again, it should be used carefully.

### History and Shell Sessions

Command history is associated with shell sessions and history configuration.

The exact behavior depends on the shell and its configuration.

Bash commonly stores persistent history in a history file in the user's home directory, such as:

~/.bash_history

The history file may be written or updated when a shell session exits, depending on configuration.

Therefore, the commands currently visible through `history` and the commands stored on disk do not necessarily represent exactly the same set of entries at every moment.

### History Is Not a Complete Audit Log

Shell history is useful evidence, but it should not be treated as a complete security audit record.

History can be:

* incomplete
* configured differently
* cleared
* affected by different shell sessions
* affected by history settings
* missing commands executed by other mechanisms

For security investigations, history should therefore be combined with other evidence such as:

* process information
* authentication logs
* system logs
* file timestamps
* network activity
* audit records
* application logs

### Practical Verification

Review recent commands:

history 10

Inspect the end of history:

history | tail -10

Search history:

history | grep "printf"

The exact results depend on the commands previously executed in the shell.

### Security Relevance

Command history can help during troubleshooting, system administration, controlled security labs, and incident investigation.

For example, it may help establish:

* which commands were recently entered
* what troubleshooting steps were attempted
* which administrative actions may have occurred
* what commands were used during a laboratory exercise

However, history should always be treated as one source of evidence rather than definitive proof of everything that happened.

### Practical Principle

Use `history` to review and understand shell activity.

Do not assume that shell history is a complete or tamper-proof record of system activity.

### Completion Check

I should be able to:

* display command history
* display a specific number of recent entries
* search history using a pipeline
* explain how history can be reused
* explain persistent Bash history
* explain why history is not a complete audit log
* identify other sources that should be considered during security investigations

## 21. Security Relevance and Command Integration

The commands in this lesson become significantly more useful when combined.

Cybersecurity work frequently requires answering questions such as:

* Where am I?
* What files exist here?
* What type of files are they?
* Who owns them?
* What permissions do they have?
* When were they modified?
* How large are they?
* Which files contain a particular pattern?
* How much storage is being used?
* What commands were recently executed?

No single command answers all of these questions.

The investigator combines several simple tools to build an understanding of the system.

### Example Investigation Workflow

A basic investigation might use:

pwd
ls -la
find
file
stat
grep
du
history

Each command contributes a different piece of information.

For example:

* `pwd` establishes location.
* `ls` shows directory contents.
* `find` locates specific files.
* `file` identifies file types.
* `stat` provides metadata.
* `grep` searches text.
* `du` examines storage usage.
* `history` provides context about recent shell activity.

### Security Principle

A command's output is information that must be interpreted in context.

For example:

* A large file is not automatically malicious.
* An unusual filename is not automatically malicious.
* A recently modified file is not automatically malicious.
* A permission such as `600` is not automatically suspicious.
* A command appearing in history does not prove that it successfully changed the system.

Good security analysis combines multiple sources of evidence.

### Command Composition

Linux becomes especially powerful when commands are combined using:

* pipelines
* redirection
* command arguments
* options
* quoting
* variables

For example:

find . -type f | sort

This first locates files and then sorts the resulting paths.

Another example:

history | grep "printf"

This searches command history for entries containing a specific pattern.

### Practical Principle

Strong Linux users do not rely on one command for every problem.

They understand what each command does and combine simple commands to answer more complicated questions.

This principle will become increasingly important in later projects involving:

* networking
* web security
* vulnerability research
* scripting
* digital forensics
* system administration
* security automation

## 22. Integrated Practical Lab

This lab combines commands learned throughout the lesson.

### Lab Objective

Create a small controlled dataset, inspect it, search it, analyze its metadata, and remove the temporary lab safely.

### Step 1 — Create the Lab

Create the directory:

mkdir -p lesson03-integration/logs lesson03-integration/docs

Create test files:

printf '%s\n' "INFO system started" "WARNING disk usage high" "ERROR test event" > lesson03-integration/logs/system.log

printf '%s\n' "Linux fundamentals" "Command practice" "Security research" > lesson03-integration/docs/notes.txt

printf '%s\n' "temporary data" > lesson03-integration/temp.txt

### Step 2 — Inspect the Location

Use:

pwd
ls -la lesson03-integration

### Step 3 — Identify Files

Use:

find lesson03-integration -type f -print

Then:

file lesson03-integration/logs/system.log
file lesson03-integration/docs/notes.txt

### Step 4 — Inspect Metadata

Use:

stat lesson03-integration/logs/system.log

### Step 5 — Search the Dataset

Search for errors:

grep -Rni "ERROR" lesson03-integration

Search for warnings:

grep -Rni "WARNING" lesson03-integration

### Step 6 — Analyze Storage

Use:

du -sh lesson03-integration
df -h .

The first command examines the directory's usage.

The second examines the filesystem containing the current directory.

### Step 7 — Review Your Work

Use:

history | tail -20

Observe how the commands used during the lab appear in shell history.

### Step 8 — Clean Up

Remove the temporary lab:

rm -r -i lesson03-integration

Answer `y` to the prompts for the files and directories created specifically for this lab.

Then verify:

find lesson03-integration -print

The expected result is an error indicating that the directory no longer exists.

### Lab Completion

The integrated lab is complete when I can:

* create a controlled dataset
* inspect directories
* locate files
* identify file types
* inspect metadata
* search file contents
* examine storage usage
* review shell history
* safely remove temporary lab data
* explain what each command contributed

## 23. Final Assessment

Answer the following without looking back through the lesson.

### Knowledge

1. What does `pwd` display?

2. What is the difference between `ls` and `find`?

3. What does `cd` change?

4. What is the purpose of `mkdir`?

5. What is the difference between `cp` and `mv`?

6. Why should `rm` be used carefully?

7. What does `cat` do?

8. What is `less` useful for?

9. What is the difference between `head` and `tail`?

10. What information can `file` provide?

11. What is `stat` used for?

12. What does `wc` count?

13. Why might `sort | uniq` be used together?

14. What does `grep` search?

15. What is `find` useful for?

16. What is the difference between `du` and `df`?

17. What is the difference between `echo` and `printf`?

18. Why is quoting important when working with shell variables?

19. What does `history` provide?

20. Why should shell history not be treated as a complete audit log?

### Applied Reasoning

21. You need to locate all `.log` files below a directory. Which command would you use?

22. You need to search those files for the word `ERROR`. Which command could you combine with the result?

23. You need to determine who owns a suspicious file and when it was modified. Which command would help?

24. You discover that a directory is consuming significant storage. Which command would you use?

25. You need to determine how much free space remains on the filesystem. Which command would you use?

26. You need to display a variable literally rather than expand it. What quoting technique can you use?

27. Why is understanding the commands more important than memorizing command sequences?

### Security Reasoning

28. Why does finding a suspicious-looking file not automatically mean that the file is malicious?

29. Why should multiple sources of evidence be combined during security investigation?

30. Explain how basic Linux commands can form the foundation for security automation and investigation.

## 24. Completion Criteria

Lesson 03 is complete when I can:

* explain the purpose of all 20 command groups covered in this lesson
* demonstrate the commands in a controlled environment
* choose appropriate commands for common filesystem and text-processing tasks
* combine commands using pipelines and arguments
* inspect files, metadata, permissions, ownership, and storage
* search for files and text
* interpret command output rather than blindly trusting it
* troubleshoot command failures
* use commands safely
* explain the security relevance of essential Linux commands
* complete the integrated practical lab
* pass the final assessment
* document important lessons and troubleshooting discoveries

## 25. Lesson Status

**Status: IN PROGRESS**

The documentation, individual command exercises, and integrated practical lab must be completed before this lesson is marked **COMPLETE**.
