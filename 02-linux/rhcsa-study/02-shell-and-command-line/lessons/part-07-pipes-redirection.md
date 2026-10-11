# Part 7 — Pipes and Redirection

## 1. What are Pipes and Redirection?

Pipes and redirection connect commands together.

They let you:
- Send output of one command to another
- Save output to files
- Read input from files
- Separate errors from output

---

## 2. Pipes (|)

A pipe sends output of one command as input to another.

Syntax: command1 | command2

Example: ps aux | grep bash

| Use | Command |
|-----|---------|
| Count processes | ps aux | wc -l |
| Filter output | ls -la | grep ".txt" |
| Chain multiple | cat file | grep error | wc -l |

---

## 3. Redirection

| Symbol | Meaning | Example |
|--------|---------|---------|
| > | Overwrite file | echo "text" > file.txt |
| >> | Append to file | echo "text" >> file.txt |
| < | Read from file | wc -l < file.txt |
| 2> | Redirect errors | command 2> error.log |
| &> | Redirect all | command &> all.log |
| 2>&1 | Merge stderr to stdout | command > file 2>&1 |

---

## 4. tee — Output to Screen and File

Syntax: command | tee file

Example: echo "hello" | tee output.txt

| Use | Command |
|-----|---------|
| Save and display | ls -la | tee listing.txt |
| Append and display | ls -la | tee -a listing.txt |

---

## 5. Command Chaining

| Symbol | Meaning | Example |
|--------|---------|---------|
| && | Run next if success | cmd1 && cmd2 |
| \|\| | Run next if failure | cmd1 \|\| cmd2 |
| ; | Run regardless | cmd1 ; cmd2 |

Examples:
- echo "first" && echo "second"
- false || echo "this runs"
- echo "one"; echo "two"

---

## 6. Real-World Examples

Count files:
ls | wc -l

Find errors in log:
grep -i error /var/log/syslog | wc -l

Save process list:
ps aux > processes.txt

Filter and save:
ps aux | grep bash > bash-processes.txt

Separate errors:
find / -name "*.conf" > found.txt 2> errors.txt

Chain commands:
mkdir /tmp/test && cd /tmp/test && touch file.txt

---

## 7. RHCSA Relevance

Pipes and redirection are used in:
- Scripting
- Log analysis
- System administration
- Troubleshooting
- Automation

---

## 8. Key Review

- `|` = pipe output to next command
- `>` = write to file (overwrite)
- `>>` = append to file
- `<` = read from file
- `2>` = redirect errors
- `&>` = redirect all output
- `tee` = screen + file
- `&&` = if success
- `||` = if failure
- `;` = always

---

Part 7 Complete. Next: Final Review
