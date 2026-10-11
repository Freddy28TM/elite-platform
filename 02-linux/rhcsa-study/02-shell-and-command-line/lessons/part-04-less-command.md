# Part 4 — less Command

## 1. What is less?

less views file contents with scrolling and search.

Better than cat for large files.

---

## 2. Basic Syntax

less [options] [file]

---

## 3. Keyboard Shortcuts

| Key | Action |
|-----|--------|
| Space | Next page |
| b | Previous page |
| Down | Next line |
| Up | Previous line |
| g | Go to beginning |
| G | Go to end |
| /pattern | Search forward |
| ?pattern | Search backward |
| n | Next match |
| N | Previous match |
| q | Quit |

---

## 4. Useful Options

| Option | Purpose |
|--------|---------|
| -N | Show line numbers |
| +F | Follow mode (like tail -f) |
| +G | Start at end |
| -S | Don't wrap long lines |

---

## 5. Piping to less

ps aux | less              — Scroll processes
ls -la /usr/bin | less     — Scroll directory
cat largefile.txt | less   — View large file
grep error log.txt | less  — Search and scroll

---

## 6. When to Use less

Use less when:
- File is large
- You need to search
- You want to scroll
- You are exploring

Use cat when:
- File is small
- Piping output
- Creating files

---

## 7. Real-World Examples

View config:
less /etc/hosts

View log:
less /var/log/syslog

Scroll processes:
ps aux | less

Search log:
less /var/log/syslog
then: /error

---

## 8. RHCSA Relevance

less is used for:
- Reading logs
- Exploring large files
- Searching configurations
- Troubleshooting

---

## 9. Key Review

- less = scroll through files
- Space = next page
- / = search forward
- n = next match
- q = quit
- -N = line numbers

---

Part 4 Complete. Next: grep Command
