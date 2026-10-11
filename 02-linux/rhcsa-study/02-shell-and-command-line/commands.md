# Lesson 02 — Essential Commands

## Command Reference

### echo — Output text

| Purpose | Example |
|---------|---------|
| Print text | echo "Hello World" |
| Print variable | echo $HOME |
| Print to file | echo "text" > file.txt |
| Append to file | echo "text" >> file.txt |

---

### cat — View files

| Purpose | Example |
|---------|---------|
| View file | cat file.txt |
| View multiple | cat file1.txt file2.txt |
| Number lines | cat -n file.txt |

---

### less — Paginated view

| Purpose | Example |
|---------|---------|
| View with scroll | less file.txt |
| Search inside | /pattern (in less) |
| Quit | q (in less) |

---

### grep — Search text

| Purpose | Example |
|---------|---------|
| Search in file | grep "error" log.txt |
| Case insensitive | grep -i "error" log.txt |
| Show line numbers | grep -n "error" log.txt |
| Recursive search | grep -r "error" /var/log/ |

---

### find — Find files

| Purpose | Example |
|---------|---------|
| Find by name | find / -name "*.conf" |
| Find by type | find / -type f |
| Find by size | find / -size +10M |
| Find by permission | find / -perm -4000 |

---

### Pipes and Redirection

| Symbol | Purpose | Example |
|--------|---------|---------|
| pipe | Chain output | ls -la | grep ".txt" |
| > | Overwrite file | echo "text" > file.txt |
| >> | Append file | echo "text" >> file.txt |
| < | Input from file | cat < file.txt |
| 2> | Redirect errors | command 2> error.log |

---

## Common Combinations

find / -type f -size +100M 2>/dev/null

grep -i "error" /var/log/syslog

grep -c "error" log.txt

cat file.txt | grep "error" | wc -l

ls -la > directory-listing.txt

---

## Practice Goals

- [ ] Use echo to create a file
- [ ] Use cat to view it
- [ ] Use less to scroll through a large file
- [ ] Use grep to find specific text
- [ ] Use find to locate files
- [ ] Combine 3+ commands with pipes
