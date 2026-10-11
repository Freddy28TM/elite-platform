# Vulnerability Testing Checklist (by class)

## Access Control
- [ ] IDOR / BOLA
- [ ] Broken Function Level Authorization
- [ ] Privilege escalation
- [ ] Horizontal & vertical access issues

## Injection
- [ ] SQL / NoSQL
- [ ] Command Injection
- [ ] SSTI
- [ ] XSS (reflected, stored, DOM)
- [ ] LDAP / XPath / etc.

## Authentication & Session
- [ ] Weak password policies
- [ ] Session fixation / prediction
- [ ] JWT issues
- [ ] OAuth / SSO flaws
- [ ] 2FA bypass

## Business Logic
- [ ] Race conditions
- [ ] Price / quantity manipulation
- [ ] Workflow bypass
- [ ] Feature abuse

## Server-Side
- [ ] SSRF
- [ ] XXE
- [ ] File upload
- [ ] Deserialization
- [ ] Request smuggling

## Client-Side & Other
- [ ] CORS misconfiguration
- [ ] Clickjacking
- [ ] Information disclosure
- [ ] Security misconfigurations
