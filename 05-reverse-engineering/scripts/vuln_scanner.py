#!/usr/bin/env python3
"""Binary Vulnerability Scanner"""

import sys
import subprocess
import re

class VulnScanner:
    def __init__(self, binary):
        self.binary = binary
        self.findings = []
    
    def run_cmd(self, cmd):
        try:
            result = subprocess.run(cmd, capture_output=True, text=True, timeout=60)
            return result.stdout
        except Exception as e:
            return f"Error: {e}"
    
    def check_dangerous_functions(self):
        disasm = self.run_cmd(['objdump', '-d', self.binary])
        dangerous = {
            'strcpy': 'CRITICAL', 'strcat': 'HIGH', 'sprintf': 'HIGH',
            'gets': 'CRITICAL', 'scanf': 'MEDIUM', 'system': 'CRITICAL',
            'popen': 'HIGH', 'memcpy': 'MEDIUM',
        }
        for func, severity in dangerous.items():
            pattern = rf'call.*<{func}@plt>'
            matches = re.findall(pattern, disasm)
            if matches:
                self.findings.append({
                    'type': 'DANGEROUS_FUNCTION',
                    'name': func,
                    'severity': severity,
                    'count': len(matches)
                })
    
    def check_protections(self):
        symbols = self.run_cmd(['readelf', '-s', self.binary])
        if '__stack_chk_fail' in symbols:
            self.findings.append({'type': 'PROTECTION', 'name': 'Stack Canary',
                                  'severity': 'INFO', 'status': 'ENABLED'})
        else:
            self.findings.append({'type': 'PROTECTION', 'name': 'Stack Canary',
                                  'severity': 'MEDIUM', 'status': 'DISABLED'})
        
        program_headers = self.run_cmd(['readelf', '-l', self.binary])
        if 'GNU_STACK' in program_headers:
            if 'RWE' in program_headers:
                self.findings.append({'type': 'PROTECTION', 'name': 'NX Bit',
                                      'severity': 'HIGH', 'status': 'DISABLED'})
            else:
                self.findings.append({'type': 'PROTECTION', 'name': 'NX Bit',
                                      'severity': 'INFO', 'status': 'ENABLED'})
        
        elf_header = self.run_cmd(['readelf', '-h', self.binary])
        if 'DYN' in elf_header:
            self.findings.append({'type': 'PROTECTION', 'name': 'PIE',
                                  'severity': 'INFO', 'status': 'ENABLED'})
        else:
            self.findings.append({'type': 'PROTECTION', 'name': 'PIE',
                                  'severity': 'MEDIUM', 'status': 'DISABLED'})
        
        if 'GNU_RELRO' in program_headers:
            if 'BIND_NOW' in self.run_cmd(['readelf', '-d', self.binary]):
                status, severity = 'FULL', 'INFO'
            else:
                status, severity = 'PARTIAL', 'LOW'
        else:
            status, severity = 'DISABLED', 'MEDIUM'
        
        self.findings.append({'type': 'PROTECTION', 'name': 'RELRO',
                              'severity': severity, 'status': status})
    
    def report(self):
        self.check_dangerous_functions()
        self.check_protections()
        print(f"\n{'='*70}")
        print(f"VULNERABILITY SCAN: {self.binary}")
        print(f"{'='*70}\n")
        by_severity = {}
        for f in self.findings:
            by_severity.setdefault(f['severity'], []).append(f)
        for sev in ['CRITICAL', 'HIGH', 'MEDIUM', 'LOW', 'INFO']:
            if sev in by_severity:
                print(f"\n[{sev}]")
                print("-" * 50)
                for f in by_severity[sev]:
                    if f['type'] == 'DANGEROUS_FUNCTION':
                        print(f"  ⚠ {f['name']} (x{f['count']})")
                    elif f['type'] == 'PROTECTION':
                        icon = "✓" if f['status'] == "ENABLED" else "✗"
                        print(f"  {icon} {f['name']}: {f['status']}")
        print(f"\n{'='*70}")
        print(f"Total findings: {len(self.findings)}")
        print(f"{'='*70}\n")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 vuln_scanner.py <binary>")
        sys.exit(1)
    scanner = VulnScanner(sys.argv[1])
    scanner.report()
