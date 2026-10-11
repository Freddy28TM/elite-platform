#!/bin/bash
if [ -z "$1" ]; then
  echo "Usage: $0 program-name"
  exit 1
fi

TARGET=$1
mkdir -p targets/$TARGET/{recon,findings}
cp reports/report-template.md targets/$TARGET/findings/
touch targets/$TARGET/scope.md targets/$TARGET/notes.md
echo "[+] Created structure for $TARGET"
ls -la targets/$TARGET
