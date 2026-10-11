# Part 8 — Final Review

**Lesson 02 — Shell and Command Line**
**Status:** COMPLETE
**Completed:** 2026-10-11

---

## What You Learned

### Part 1 — Shell Basics

| Command | Purpose |
|---------|---------|
| $SHELL | Show current shell |
| $PATH | Command search path |
| man | Manual pages |
| --help | Quick help |

### Part 2 — echo Command

| Command | Purpose |
|---------|---------|
| echo | Output text |
| > | Overwrite file |
| >> | Append to file |
| -e | Enable escapes |
| -n | No newline |

### Part 3 — cat Command

| Command | Purpose |
|---------|---------|
| cat | View files |
| cat -n | Number lines |
| cat -b | Number non-blank |
| cat -E | Show line endings |
| cat > file | Create file |

### Part 4 — less Command

| Key | Action |
|-----|--------|
| Space | Next page |
| b | Previous page |
| /pattern | Search forward |
| n | Next match |
| q | Quit |

### Part 5 — grep Command

| Command | Purpose |
|---------|---------|
| grep | Search text |
| -i | Case insensitive |
| -v | Invert match |
| -n | Line numbers |
| -c | Count matches |
| -r | Recursive |

### Part 6 — find Command

| Command | Purpose |
|---------|---------|
| find | Search files |
| -name | By name |
| -type | By type (f, d, l) |
| -size | By size |
| -perm | By permission |
| -exec | Execute command |

### Part 7 — Pipes and Redirection

| Symbol | Meaning |
|--------|---------|
| \| | Pipe to next command |
| > | Write to file |
| >> | Append to file |
| < | Read from file |
| 2> | Redirect errors |
| &> | Redirect all |
| tee | Screen + file |
| && | If success |
| \|\| | If failure |
| ; | Always |

---

## Scripts Built

| Script | Purpose |
|--------|---------|
| shell-basics.sh | Shell exploration |
| echo-lab.sh | echo practice |
| cat-lab.sh | cat practice |
| less-lab.sh | less practice |
| grep-lab.sh | grep practice |
| find-lab.sh | find practice |
| pipes-lab.sh | Pipes practice |

---

## Skills Mastered

- [x] Identify shell environment
- [x] Get help with man pages
- [x] Output text with echo
- [x] View files with cat
- [x] Scroll with less
- [x] Search with grep
- [x] Find files with find
- [x] Chain commands with pipes
- [x] Redirect output to files

---

## RHCSA Relevance

This lesson establishes skills used in every RHCSA task:

- Reading configuration files
- Searching logs
- Finding files
- Filtering output
- Combining commands
- Building automation scripts

---

## Next Lesson

**Module 03 — Files and Filesystems**

Location: `03-files-and-filesystems/`

---

**Lesson 02 is complete. Move to Module 03.**
