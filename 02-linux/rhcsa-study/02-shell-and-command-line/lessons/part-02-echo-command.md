# Part 2 — echo Command

## 1. What is echo?

echo prints text to standard output.

It is the simplest command, but extremely useful for:

- Displaying messages
- Writing to files
- Debugging scripts
- Testing variables

---

## 2. Basic Syntax

echo [options] [string]

---

## 3. Common Uses

| Use | Command |
|-----|---------|
| Print text | echo "Hello" |
| Print variable | echo $HOME |
| Print command result | echo $(date) |
| Write to file | echo "text" > file.txt |
| Append to file | echo "text" >> file.txt |
| Multi-line | echo -e "Line1\nLine2" |
| No newline | echo -n "text" |

---

## 4. Options

| Option | Meaning |
|--------|---------|
| -n | No trailing newline |
| -e | Enable backslash escapes |
| -E | Disable backslash escapes (default) |

---

## 5. Escape Sequences (with -e)

| Sequence | Meaning |
|----------|---------|
| \n | New line |
| \t | Tab |
| \\ | Backslash |
| \a | Alert (bell) |

---

## 6. Variables

| Variable | Meaning |
|----------|---------|
| $HOME | Home directory |
| $USER | Current user |
| $SHELL | Current shell |
| $PATH | Command search path |
| $? | Last command exit code |

---

## 7. Redirection

| Symbol | Meaning |
|--------|---------|
| > | Overwrite file |
| >> | Append to file |
| 2> | Redirect errors |
| &> | Redirect all output |

---

## 8. Real-World Examples

Create a log entry:
echo "$(date): User logged in" >> /var/log/logins.log

Debug a script:
echo "Variable x = $x"

Print to screen and file:
echo "Result: success" | tee output.txt

Clear a file:
echo -n "" > file.txt

---

## 9. RHCSA Relevance

echo is used in:

- Scripting
- Configuration file creation
- Log messages
- Testing variables
- Writing to files

Understanding echo is essential for Bash scripting in RHCSA.

---

## 10. Key Review

- echo prints text
- Use > to write, >> to append
- Use -e for escapes like \n
- Use -n to suppress newline
- Variables: $HOME, $USER, $PATH

---

Part 2 Complete. Next: cat Command
