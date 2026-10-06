#!/usr/bin/env python3
"""String Analyzer - Find interesting strings in binaries"""

import sys
import re
import subprocess

class StringAnalyzer:
    def __init__(self, binary_path):
        self.binary = binary_path
        self.patterns = {
            'urls': r'https?://[^\s<>"\']+',
            'emails': r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}',
            'ipv4': r'\b(?:\d{1,3}\.){3}\d{1,3}\b',
            'passwords': r'(?i)(password|passwd|pwd|secret)\s*[=:]\s*\S+',
            'api_keys': r'(?i)(api[_-]?key|apikey)\s*[=:]\s*\S+',
            'tokens': r'(?i)(token|bearer)\s*[=:]\s*\S+',
            'aws_key': r'AKIA[0-9A-Z]{16}',
            'private_key': r'-----BEGIN.*PRIVATE KEY-----',
            'file_paths': r'(?:/[a-zA-Z0-9_.-]+)+/?',
            'format_strings': r'%[0-9]*[sdxnp]',
        }
    
    def extract_strings(self):
        result = subprocess.run(['strings', '-a', '-n', '4', self.binary],
                               capture_output=True, text=True)
        return result.stdout.split('\n')
    
    def analyze(self):
        strings = self.extract_strings()
        findings = {}
        for category, pattern in self.patterns.items():
            findings[category] = []
            for s in strings:
                matches = re.findall(pattern, s)
                for match in matches:
                    if match and len(str(match)) > 3:
                        findings[category].append(str(match))
        return findings
    
    def report(self):
        findings = self.analyze()
        print(f"\n{'='*70}")
        print(f"STRING ANALYSIS: {self.binary}")
        print(f"{'='*70}\n")
        total = 0
        for category, items in findings.items():
            if items:
                unique_items = list(set(items))
                print(f"\n[{category.upper()}] ({len(unique_items)} found)")
                print("-" * 50)
                for item in unique_items[:20]:
                    print(f"  {item[:100]}")
                if len(unique_items) > 20:
                    print(f"  ... and {len(unique_items) - 20} more")
                total += len(unique_items)
        print(f"\n{'='*70}")
        print(f"TOTAL INTERESTING STRINGS: {total}")
        print(f"{'='*70}\n")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 string_analyzer.py <binary>")
        sys.exit(1)
    analyzer = StringAnalyzer(sys.argv[1])
    analyzer.report()
