# Lesson 01 — Linux Environment Notes

**Date Started:** 2026-10-11
**Date Completed:** 

## Commands Mastered

| # | Command | Purpose | Practiced |
|---|---------|---------|-----------|
| 1 | whoami | Show current user | ✅ |
| 2 | pwd | Show current directory | ✅ |
| 3 | hostname | Show machine name | ✅ |
| 4 | cat /etc/os-release | Show distribution | ✅ |
| 5 | uname -r | Show kernel release | ✅ |
| 6 | uname -a | Show all system info | ✅ |
| 7 | uname -m | Show architecture | ✅ |

## My System Profile

- **User:** fredrick
- **Hostname:** parrot
- **Distribution:** Parrot Security 7.4 (echo)
- **Debian Version:** 13.6
- **Kernel:** 7.1.13+parrot7-amd64
- **Architecture:** x86_64

## What I Built

**system-report.sh** — A script that combines all 7 commands into one formatted report.

Located at: `commands/system-report.sh`

## Key Concepts

1. **Identify first, change second** — Always know the system before modifying.
2. **User identity matters** — whoami tells you your permissions context.
3. **Paths matter** — Absolute paths start from `/`, relative from current dir.
4. **Distribution ≠ Kernel** — Different pieces of information.
5. **Architecture matters** — Software must match (x86_64, ARM, etc).

## Challenges

- Remembering the difference between `uname -r` (kernel) and `uname -m` (architecture).
- Understanding absolute vs relative paths.

## Summary

Lesson 01 teaches system identification. These 7 commands form the foundation for all Linux administration work. Before any task, identify the system.

**Part 1 of Lesson 01 is complete. Parts 2-8 remain.**

