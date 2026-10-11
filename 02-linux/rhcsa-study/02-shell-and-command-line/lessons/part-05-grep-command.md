# Part 5 — grep Command

## 1. What is grep?

grep searches text in files and outputs matching lines.

Name comes from "Global Regular Expression Print".

---

## 2. Basic Syntax

grep [options] pattern [file...]

---

## 3. Common Options

| Option | Purpose |
|--------|---------|
| -i | Case insensitive |
| -v | Invert match (not matching) |
| -n | Show line numbers |
| -c | Count matches |
| -l | Show filenames only |
| -r | Recursive search |
| -E | Extended regex |
| -A n | Show n lines after |
| -B n | Show n lines before |
| -C n | Show n lines context |

---

## 4. Common Uses

| Use | Command |
|-----|---------|
| Search file | grep "error" log.txt |
| Case insensitive | grep -i "error" log.txt |
| Show line numbers | grep -n "error" log.txt |
| Count matches | grep -c "error" log.txt |
| Invert match | grep -v "success" log.txt |
| Multiple patterns | grep -E "error\|warning" log.txt |
| Recursive | grep -r "error" /var/log/ |
| Context | grep -A 2 "error" log.txt |

---

## 5. Regular Expressions

| Pattern | Meaning |
|---------|---------|
| . | Any character |
| * | Zero or more |
| + | One or more |
| ? | Zero or one |
| ^ | Beginning of line |
| $ | End of line |
| [abc] | Any of a, b, c |
| [^abc] | Not a, b, c |
| \| | OR (with -E) |

---

## 6. Real-World Examples

Find errors in log:
grep -i "error" /var/log/syslog

Count failed logins:
grep -c "Failed password" /var/log/auth.log

Find configuration:
grep -r "Listen" /etc/apache2/

Show process with context:
ps aux | grep -A 1 nginx

---

## 7. Piping with grep

ps aux | grep nginx              — Find nginx process
ls -la | grep ".txt"             — Find txt files
cat logfile.txt | grep ERROR     — Filter output
find / -name "*.conf" | grep ssh — Search results

---

## 8. RHCSA Relevance

grep is used for:

- Searching log files
- Filtering command output
- Finding configuration values
- Troubleshooting
- Security investigation

---

## 9. Key Review

- grep = search text
- -i = case insensitive
- -v = invert
- -n = line numbers
- -c = count
- -r = recursive
- -E = extended regex

---

Part 5 Complete. Next: find Command
