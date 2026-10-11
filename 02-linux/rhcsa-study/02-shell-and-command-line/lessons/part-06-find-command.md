# Part 6 — find Command

## 1. What is find?

find searches for files and directories based on various criteria.

It is one of the most powerful Linux commands.

---

## 2. Basic Syntax

find [path] [options] [expression]

---

## 3. Common Options

| Option | Purpose |
|--------|---------|
| -name | Match filename |
| -iname | Case-insensitive name |
| -type | File type (f, d, l) |
| -size | File size |
| -mtime | Modification time |
| -perm | Permissions |
| -user | Owner |
| -exec | Execute command |
| -delete | Delete matches |

---

## 4. Search by Name

| Use | Command |
|-----|---------|
| Exact name | find /etc -name "hostname" |
| Wildcard | find /etc -name "*.conf" |
| Case insensitive | find /etc -iname "HOSTS" |

---

## 5. Search by Type

| Type | Flag | Example |
|------|------|---------|
| File | -type f | find /etc -type f |
| Directory | -type d | find /etc -type d |
| Symlink | -type l | find /usr -type l |

---

## 6. Search by Size

| Size | Flag |
|------|------|
| Larger than 10M | -size +10M |
| Smaller than 10M | -size -10M |
| Exactly 10M | -size 10M |

---

## 7. Search by Time

| Time | Flag |
|------|------|
| Last 24 hours | -mtime -1 |
| Last 7 days | -mtime -7 |
| More than 30 days | -mtime +30 |

---

## 8. Search by Permission

| Permission | Flag |
|------------|------|
| SUID | -perm -4000 |
| SGID | -perm -2000 |
| World-writable | -perm -002 |

---

## 9. Execute on Results

find /tmp -name "*.tmp" -delete

find /var/log -name "*.log" -exec rm {} \;

find /etc -name "*.conf" -exec grep -l "Listen" {} \;

---

## 10. Real-World Examples

Find all config files:
find /etc -name "*.conf"

Find SUID files (security):
find / -perm -4000 -type f 2>/dev/null

Find large files:
find / -size +100M -type f 2>/dev/null

Find recent logs:
find /var/log -mtime -7

Find and delete temp files:
find /tmp -name "*.tmp" -delete

---

## 11. RHCSA Relevance

find is used for:

- Locating files
- Security audits (SUID)
- Cleanup scripts
- Troubleshooting
- Filesystem exploration

---

## 12. Key Review

- find = search files
- -name = by name
- -type = file/dir/link
- -size = by size
- -mtime = by time
- -perm = by permission
- -exec = run command
- -delete = delete results

---

Part 6 Complete. Next: Pipes and Redirection
