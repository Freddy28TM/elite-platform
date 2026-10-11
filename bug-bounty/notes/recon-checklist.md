# Professional Recon Checklist

## 1. Scope Review
- [ ] Read full program policy
- [ ] Note in-scope & out-of-scope assets
- [ ] Note rate limits / forbidden actions
- [ ] Note preferred severity & payout ranges

## 2. Asset Discovery
- [ ] Subdomain enumeration (subfinder, amass, chaos)
- [ ] Certificate Transparency
- [ ] ASN / IP ranges
- [ ] Historical data (wayback, gau)
- [ ] Mobile apps (if in scope)
- [ ] GitHub / GitLab / public repos
- [ ] Cloud buckets / storage

## 3. Live Hosts & Fingerprinting
- [ ] httpx / naabu
- [ ] Technology detection
- [ ] Screenshotting (optional)
- [ ] Interesting ports/services

## 4. Content Discovery
- [ ] Directory/file fuzzing (ffuf)
- [ ] Parameter discovery
- [ ] JavaScript analysis
- [ ] API endpoints

## 5. Continuous Monitoring
- [ ] New subdomains
- [ ] New JS files
- [ ] Changelog / blog monitoring
