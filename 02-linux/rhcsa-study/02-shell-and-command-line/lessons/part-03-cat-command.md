# Part 3 — cat Command

## 1. What is cat?

cat (concatenate) displays file contents.

It is one of the most-used commands for viewing files.

---

## 2. Basic Syntax

cat [options] [file...]

---

## 3. Common Uses

| Use | Command |
|-----|---------|
| View file | cat file.txt |
| View multiple | cat file1.txt file2.txt |
| Number lines | cat -n file.txt |
| Create file | cat > newfile.txt |
| Append to file | cat >> newfile.txt |

---

## 4. Options

| Option | Meaning |
|--------|---------|
| -n | Number all lines |
| -b | Number non-blank lines |
| -E | Show end of lines ($) |
| -T | Show tabs (^I) |
| -s | Squeeze blank lines |
| -A | Show all (equivalent to -vET) |

---

## 5. Viewing Files

cat file.txt           — View entire file
cat file1.txt file2.txt  — Concatenate files
cat -n file.txt        — With line numbers
cat -b file.txt        — Number non-blank only
cat -E file.txt        — Show line endings
cat -T file.txt        — Show tabs

---

## 6. Creating Files

cat > newfile.txt      — Create (Ctrl+D to end)
cat >> newfile.txt     — Append (Ctrl+D to end)

---

## 7. Real-World Examples

View config file:
cat /etc/hostname

Combine files:
cat part1.txt part2.txt > combined.txt

Number lines in log:
cat -n /var/log/syslog

Create script:
cat > script.sh

---

## 8. When NOT to Use cat

For large files, use less instead:

- cat is for small files or pipes
- less is for scrolling through large files
- cat dumps everything at once
- less allows scrolling and searching

---

## 9. RHCSA Relevance

cat is used for:

- Reading configuration files
- Viewing logs
- Creating files in scripts
- Concatenating output
- Debugging

Understanding cat is essential for Linux administration.

---

## 10. Key Review

- cat = view file contents
- -n = number lines
- -b = number non-blank
- -E = show line endings
- -T = show tabs
- > create, >> append

---

Part 3 Complete. Next: less Command
