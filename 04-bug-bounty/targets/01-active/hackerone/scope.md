# HackerOne Bug Bounty Program - Scope Notes

## Main In-Scope Assets (many can be tested without login)
- hackerone.com
- www.hackerone.com
- api.hackerone.com
- docs.hackerone.com
- support.hackerone.com
- *.hackerone-user-content.com
- errors.hackerone.net
- ctf.hacker101.com
- reviewer.pullrequest.com

## Important Rules
- Always send this header on every request:
  X-Bug-Bounty: HackerOne-YOUR_H1_USERNAME
- Read the full official policy on HackerOne before deep testing
- Focus on impactful findings
- Do not perform DoS or aggressive scanning

## Notes for unauthenticated testing
- Marketing site (www.hackerone.com)
- Documentation (docs.hackerone.com)
- Public API endpoints
- Support pages
- Static / public content
