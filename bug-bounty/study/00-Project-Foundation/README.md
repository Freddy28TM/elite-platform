# 🔵 STAGE 0 — PROJECT FOUNDATION

## Professional Bug Bounty Learning & Research Environment

---

# 0. Stage Overview

Before learning individual vulnerabilities, a security researcher needs a professional foundation.

Bug bounty research is not simply a collection of tools and vulnerability names.

A professional workflow requires:

* Authorization
* Ethics
* Scope awareness
* Program understanding
* A controlled research environment
* Version control
* Documentation
* Repeatable methodology
* Evidence management
* Impact analysis
* Responsible reporting

This stage establishes those foundations.

The objective is to build a working environment that can support the rest of the Bug Bounty Lab without repeatedly redefining how research is performed.

---

# 1. Stage Objectives

By the end of Stage 0, the researcher should understand:

1. What bug bounty hunting is.
2. How authorized security research differs from unauthorized access.
3. How bug bounty programs define permission.
4. How scope and rules determine what may be tested.
5. How the BugBounty-lab project is structured.
6. How Git is used to preserve research history.
7. How professional security documentation is written.
8. How to build a repeatable testing methodology.
9. How to collect and organize evidence.
10. How to reason about vulnerability severity and impact.

---

# 2. Stage 0 Syllabus

| Lesson | Topic                                             |
| ------ | ------------------------------------------------- |
| 0.1    | Introduction to Bug Bounty Hunting                |
| 0.2    | Ethics, Authorization, and Responsible Disclosure |
| 0.3    | Understanding Bug Bounty Programs                 |
| 0.4    | Setting Up the BugBounty-lab Project              |
| 0.5    | Git Workflow and Documentation Standards          |
| 0.6    | Building a Professional Testing Methodology       |
| 0.7    | Evidence Collection and Organization              |
| 0.8    | Understanding Vulnerability Severity and Impact   |

### Stage Deliverable

> A structured, version-controlled Bug Bounty learning and research environment with documented methodology, ethical boundaries, program/scope handling, Git workflow, evidence standards, and an evidence-based approach to vulnerability impact.

---

# 3. 0.1 — Introduction to Bug Bounty Hunting

## 3.1 What Is Bug Bounty Hunting?

Bug bounty hunting is a form of authorized security research in which organizations invite security researchers to identify and report security weaknesses in specified systems.

A researcher typically:

```text
Understand authorization
        ↓
Understand scope
        ↓
Study the application
        ↓
Identify possible weaknesses
        ↓
Validate the behavior
        ↓
Document evidence
        ↓
Report through the authorized channel
```

The organization may then:

* Validate the report
* Determine its impact
* Fix the issue
* Communicate with the researcher
* Provide recognition or a reward where applicable

---

## 3.2 Bug Bounty Hunting Is Not "Hacking Anything"

The term "hacking" is often used broadly.

Security research has a critical distinction:

> **Technical capability does not create authorization.**

A researcher may discover:

```text
example-target.com
```

That does not automatically mean the researcher is permitted to test it.

Authorization must come from an appropriate source, such as:

* A bug bounty program policy
* A vulnerability disclosure program
* A written authorization
* A controlled laboratory environment
* An organization explicitly granting permission

---

## 3.3 Security Research vs Unauthorized Access

The same technical action can have completely different meanings depending on authorization.

For example:

```text
Authorized:
Testing a program-listed endpoint according to its rules.

Unauthorized:
Testing a discovered endpoint simply because it is publicly reachable.
```

Therefore:

```text
Discovery ≠ Authorization
Reachability ≠ Permission
Authentication ≠ Authorization
Technical possibility ≠ Legal permission
```

These principles will remain fundamental throughout the entire lab.

---

# 4. The Bug Bounty Research Lifecycle

A professional investigation can be represented as:

```text
AUTHORIZATION
     ↓
SCOPE
     ↓
RULES
     ↓
RESEARCH
     ↓
OBSERVATION
     ↓
VALIDATION
     ↓
EVIDENCE
     ↓
IMPACT ANALYSIS
     ↓
REPORT
     ↓
TRIAGE
     ↓
RETEST
     ↓
CLOSURE
```

Each stage has a purpose.

Skipping stages increases the chance of:

* Testing the wrong system
* Violating program rules
* Producing unreliable findings
* Losing evidence
* Overstating impact
* Creating unnecessary risk

---

# 5. Researcher Mindset

A professional researcher should be:

### Curious

Investigate unexpected behavior.

### Skeptical

Do not assume that unusual behavior is automatically a vulnerability.

### Methodical

Follow a repeatable process.

### Evidence-driven

Separate observations from conclusions.

### Conservative

Use the smallest test necessary to establish a finding.

### Respectful

Treat systems, data, users, and program staff responsibly.

### Reproducible

Document enough information for another authorized researcher to understand the result.

---

# 6. 0.2 — Ethics, Authorization, and Responsible Disclosure

## 6.1 Authorization Is the First Security Control

Before technical testing begins:

```text
Who authorized the testing?
What assets are authorized?
What activities are allowed?
What activities are prohibited?
When is testing allowed?
What special conditions apply?
```

If these questions cannot be answered, testing should not begin.

---

# 7. Scope of Permission

Authorization normally defines boundaries around:

### Assets

Examples:

* Domains
* Subdomains
* APIs
* Applications
* Mobile applications
* IP addresses
* Cloud resources

### Activities

Examples:

* Web testing
* API testing
* Authentication testing
* Vulnerability research
* Automated scanning

### Restrictions

Examples:

* No denial-of-service testing
* No social engineering
* No physical attacks
* No destructive actions
* No testing of third-party infrastructure

The actual rules always come from the applicable program.

---

# 8. Responsible Security Research

Responsible research means attempting to identify security weaknesses without unnecessarily harming systems or people.

Core principles:

```text
Stay authorized.
Stay within scope.
Minimize impact.
Minimize data access.
Avoid unnecessary disruption.
Preserve evidence.
Report responsibly.
Respect program instructions.
```

---

# 9. Data Minimization

A researcher should access the minimum data necessary to establish a finding.

For example, if a vulnerability can be demonstrated using:

```text
Researcher-controlled test account A
Researcher-controlled test account B
```

there is no reason to access unrelated real-user information.

The objective is:

> **Prove the security issue, not maximize access.**

---

# 10. Non-Destructive Testing

Proof of concept should normally be:

* Controlled
* Minimal
* Reversible
* Non-destructive

Avoid unnecessary:

* Data deletion
* Data modification
* Service disruption
* Resource exhaustion
* Account lockouts
* Production changes

If a program specifically authorizes a higher-impact test, follow its exact rules.

---

# 11. Responsible Disclosure

A researcher should use the reporting mechanism specified by the organization.

The normal process is:

```text
Discover
   ↓
Validate
   ↓
Document
   ↓
Report
   ↓
Communicate
   ↓
Retest
```

Do not publicly disclose sensitive details simply because a vulnerability has been discovered.

Follow the program's disclosure policy.

---

# 12. 0.3 — Understanding Bug Bounty Programs

## 12.1 What Is a Bug Bounty Program?

A bug bounty program establishes rules under which an organization accepts security reports from researchers.

A program normally defines:

* In-scope assets
* Out-of-scope assets
* Vulnerability categories
* Testing restrictions
* Reporting requirements
* Reward rules, where applicable
* Disclosure policy
* Safe-harbor language, where applicable

The program policy is the operational source of truth for that engagement.

---

# 13. Program Types

Common program models include:

### Public Programs

Generally visible to the broader research community.

### Private Programs

Access is restricted to invited researchers.

### Vulnerability Disclosure Programs

Focus primarily on receiving security reports and may not provide monetary rewards.

### Internal or Organization-Specific Programs

Research performed under an organization's own authorization.

The exact terms vary by organization.

---

# 14. Program Intake

Before working on a program, create an intake record.

```text
Program:
Organization:
Program URL:
Date reviewed:
Scope reviewed:
Rules reviewed:
Testing restrictions:
Reporting channel:
Special requirements:
Research status:
```

This creates a documented starting point.

---

# 15. Scope

Scope defines what assets are authorized.

Possible scope formats include:

```text
example.com
*.example.com
api.example.com
https://example.com/application
192.0.2.10
```

These are not necessarily equivalent.

A wildcard may cover some hosts while excluding others.

A root domain may not automatically authorize every related domain.

An IP address may belong to infrastructure that is not covered by the program.

Always interpret scope according to the program's wording.

---

# 16. In-Scope, Out-of-Scope, and Ambiguous Assets

Use three states:

```text
IN-SCOPE
OUT-OF-SCOPE
AMBIGUOUS
```

If an asset is ambiguous:

> **Do not assume permission.**

Seek clarification or exclude it from testing.

---

# 17. Rules of Engagement

Rules can restrict:

* Request rates
* Automated scanning
* Brute-force attempts
* Authentication testing
* File uploads
* SSRF testing
* Internal service access
* Denial-of-service testing
* Social engineering
* Physical testing
* Data access
* Third-party services

A target can be in scope while a particular testing technique is prohibited.

Therefore:

> **Scope tells you WHERE. Rules tell you HOW.**

---

# 18. Scope Verification Workflow

Before testing:

```text
1. Identify the program.
2. Read the current policy.
3. Record the scope.
4. Record exclusions.
5. Record testing restrictions.
6. Identify special requirements.
7. Verify the specific target.
8. Confirm the intended technique is permitted.
9. Begin testing only after authorization is clear.
```

---

# 19. 0.4 — Setting Up the BugBounty-lab Project

## 19.1 Purpose

The BugBounty-lab is the structured learning and research environment for this curriculum.

It should provide:

* A predictable directory structure
* Documentation
* Version control
* Methodology
* Labs
* Notes
* Evidence standards
* Research records
* Progress tracking

---

# 20. Project Architecture

The long-term structure is:

```text
~/Cybersecurity-projects/02-Bugbounty-lab/
│
├── README.md
│
├── 00-Project-Foundation/
│   └── README.md
│
├── 01-Web-Foundations/
│   └── README.md
│
├── 02-Burp-Suite/
│   └── README.md
│
├── 03-Core-Vulnerabilities/
│   └── README.md
│
├── 04-APIs/
│   └── README.md
│
├── 05-Authentication-and-Authorization/
│   └── README.md
│
├── 06-Advanced-Web-Vulnerabilities/
│   └── README.md
│
├── 07-Methodology-and-Research/
│   └── README.md
│
└── ...
```

The exact future stages may evolve as the curriculum develops.

---

# 21. Individual Project Phase

The initial Bug Bounty Lab can be developed independently under:

```text
~/BugBounty/
```

This allows the curriculum to be built and tested before integrating it into:

```text
~/Cybersecurity-projects/02-Bugbounty-lab/
```

The important principle is separation between:

```text
Learning environment
```

and:

```text
Actual authorized program workspaces
```

---

# 22. Learning Project vs Target Workspace

The BugBounty Lab itself should not become a dumping ground for target-specific data.

For example:

```text
~/Cybersecurity-projects/02-Bugbounty-lab/
```

contains:

* Methodology
* Lessons
* Labs
* Templates
* Documentation
* General tooling knowledge

Whereas an authorized program workspace can contain:

```text
~/BugBounty/ALSCO-SecureGateway/
```

containing program-specific:

* Scope
* Reconnaissance
* Evidence
* Reports
* Findings
* Program communications

This separation improves organization and reduces accidental data mixing.

---

# 23. Directory Standards

Each learning stage should have a predictable structure.

Example:

```text
01-Web-Foundations/
├── README.md
├── notes/
├── labs/
├── exercises/
└── evidence/
```

The exact structure can be adapted when the stage is developed.

---

# 24. Naming Standards

Use:

* Descriptive names
* Consistent capitalization
* Numeric ordering
* Clear file extensions

Example:

```text
00-Project-Foundation
01-Web-Foundations
02-Burp-Suite
03-Core-Vulnerabilities
```

Avoid inconsistent naming such as:

```text
webstuff
WebStuff
WEB-FOUNDATIONS
web_foundations_final
```

Consistency matters more than personal preference.

---

# 25. 0.5 — Git Workflow and Documentation Standards

## 25.1 Why Git?

Git provides a history of project changes.

It allows the researcher to:

* Track progress
* Review previous states
* Revert mistakes
* Compare changes
* Document development
* Establish milestones

Git is part of the professional workflow, not merely a backup mechanism.

---

# 26. Git Repository Philosophy

The repository should tell the story of how the Bug Bounty Lab developed.

A useful history might look like:

```text
Initialize Bug Bounty Lab
Add Stage 0 foundation
Document ethics and authorization methodology
Add project structure
Add evidence standards
Add Web Foundations
Add HTTP fundamentals
...
```

Commits should describe meaningful changes.

---

# 27. Commit Standards

Prefer:

```text
docs: add Stage 0 project foundation
docs: define evidence standards
docs: add web foundations
lab: add HTTP request analysis exercise
fix: correct scope documentation
```

Avoid:

```text
update
stuff
changes
final
done
test
```

A commit message should communicate what changed.

---

# 28. Commit Frequency

Commit after meaningful milestones.

For example:

```text
Complete Stage 0 foundation
```

is more useful than:

```text
Commit every five minutes
```

But avoid accumulating months of work into one giant commit.

A useful balance is:

```text
Meaningful change
      ↓
Review
      ↓
Test
      ↓
Commit
```

---

# 29. Documentation Standards

Technical documentation should be:

### Clear

Another researcher should understand it.

### Accurate

Do not document behavior that was not verified.

### Reproducible

Include necessary steps.

### Structured

Use headings, tables, lists, and code blocks appropriately.

### Versioned

Important changes should be tracked.

### Evidence-based

Separate observation from interpretation.

---

# 30. Secrets and Git

Never intentionally commit:

```text
Passwords
API keys
Private tokens
Session credentials
Private certificates
.env files containing secrets
Sensitive personal information
Unredacted private evidence
```

Use `.gitignore` where appropriate.

Example:

```gitignore
.env
*.key
*.pem
secrets/
private/
```

But remember:

> **A `.gitignore` file does not remove a secret that has already been committed.**

Always inspect what is being staged.

---

# 31. Documentation Hierarchy

The BugBounty-lab should distinguish:

```text
Curriculum
    ↓
Methodology
    ↓
Lab
    ↓
Observation
    ↓
Finding
    ↓
Evidence
    ↓
Report
```

This prevents learning material from becoming mixed with operational target data.

---

# 32. 0.6 — Building a Professional Testing Methodology

## 32.1 What Is Methodology?

Methodology is a repeatable process for conducting research.

It answers:

> "What do I do next, and why?"

A methodology prevents random tool usage from becoming the primary research strategy.

---

# 33. Professional Testing Cycle

The core methodology is:

```text
1. AUTHORIZATION
       ↓
2. SCOPE
       ↓
3. RULES
       ↓
4. RECONNAISSANCE
       ↓
5. ATTACK-SURFACE MAPPING
       ↓
6. ENUMERATION
       ↓
7. HYPOTHESIS
       ↓
8. CONTROLLED TEST
       ↓
9. VALIDATION
       ↓
10. EVIDENCE
       ↓
11. IMPACT ANALYSIS
       ↓
12. REPORT
       ↓
13. RETEST
```

---

# 34. Authorization Gate

Before any technical action:

```text
[ ] Authorization identified
[ ] Program identified
[ ] Target confirmed
[ ] Scope checked
[ ] Rules checked
[ ] Testing technique permitted
```

If any critical item is unknown:

```text
STOP
```

Resolve the uncertainty first.

---

# 35. Reconnaissance

Reconnaissance is the process of learning about an authorized target.

Examples include identifying:

* Domains
* Applications
* Endpoints
* Technologies
* APIs
* Authentication surfaces
* Input points
* Publicly documented functionality

Reconnaissance should remain within authorization boundaries.

---

# 36. Attack-Surface Mapping

Instead of immediately searching for vulnerabilities, build an understanding of the application.

Map:

```text
Application
├── Authentication
├── User management
├── Profiles
├── Search
├── Uploads
├── APIs
├── Administration
├── Payments
├── Integrations
└── Other functionality
```

The exact categories depend on the application.

---

# 37. Hypothesis-Driven Testing

A professional researcher forms a hypothesis.

Example:

```text
Observation:
An object identifier appears to be client-controlled.

Hypothesis:
The server may not correctly enforce object-level authorization.

Test:
Use two authorized test accounts and compare access behavior.

Expected:
Account B cannot access Account A's object.

Actual:
Record the observed result.
```

This is more useful than blindly running tools.

---

# 38. Validation

A suspicious behavior is not automatically a vulnerability.

Validation asks:

```text
Can it be reproduced?

Is it actually a security boundary violation?

Is the behavior caused by a legitimate application feature?

Is the target authorized?

Is the behavior within program rules?

Can it be demonstrated safely?
```

---

# 39. Controlled Proof of Concept

The PoC should establish the smallest necessary security consequence.

For example:

```text
Researcher-controlled object
```

is preferable to:

```text
Unrelated real-user object
```

when the former proves the same issue.

---

# 40. Finding Lifecycle

A finding moves through states:

```text
OBSERVED
   ↓
VALIDATING
   ↓
CONFIRMED
   ↓
EVIDENCE READY
   ↓
REPORT READY
   ↓
SUBMITTED
   ↓
TRIAGED
   ↓
RETEST
   ↓
CLOSED
```

A finding should not be reported merely because it looks interesting.

---

# 41. 0.7 — Evidence Collection and Organization

## 41.1 Evidence Principle

> **Evidence must support the claim.**

The objective is not maximum data collection.

The objective is sufficient proof.

---

# 42. Evidence Categories

Useful evidence can include:

* HTTP requests
* HTTP responses
* Screenshots
* Video
* Logs
* Timestamps
* Test-account context
* Reproduction steps
* Application behavior
* Relevant configuration
* Tool output

Only capture what is necessary.

---

# 43. HTTP Evidence

For a web or API finding, preserve relevant request and response information.

Example:

```text
REQUEST
-------

GET /api/example/123 HTTP/1.1
Host: target.example
...

RESPONSE
--------

HTTP/1.1 200 OK
Content-Type: application/json
...

{
  "relevant": "data"
}
```

Remove unnecessary sensitive information before sharing.

---

# 44. Screenshots

Screenshots should show enough context to establish the behavior.

Useful information can include:

* Application
* URL
* Relevant action
* Result

Avoid unnecessary:

* Personal data
* Credentials
* Tokens
* Private documents

---

# 45. Reproduction Documentation

A reproduction procedure should answer:

```text
What account was used?
What prerequisite existed?
What endpoint was accessed?
What action was performed?
What changed?
What response occurred?
```

Use numbered steps.

---

# 46. Expected vs Actual

Always distinguish:

### Expected

What should happen according to the security boundary.

### Actual

What the application actually did.

Example:

```text
Expected:
A user can access only objects they are authorized to access.

Actual:
The application returned a second test account's object after
the object identifier was changed.
```

---

# 47. Sensitive Data

Potentially sensitive information includes:

* Passwords
* Session tokens
* API keys
* Personal information
* Private documents
* Credentials
* Internal secrets

Use redaction:

```text
Authorization: Bearer [REDACTED]
```

Never publish secrets simply because they were encountered.

---

# 48. Evidence Directory

A finding can use:

```text
F-001/
├── notes.md
├── reproduction.md
├── evidence/
│   ├── request.txt
│   ├── response.txt
│   └── screenshot-01.png
└── report.md
```

This keeps evidence associated with the finding.

---

# 49. Evidence Naming

Prefer:

```text
F-001-request.txt
F-001-response.txt
F-001-screenshot-01.png
F-001-reproduction.md
```

Avoid:

```text
final.txt
new.txt
test2.txt
stuff.png
```

---

# 50. Evidence Integrity

For important evidence, a SHA-256 hash can be recorded:

```bash
sha256sum response.txt
```

The hash helps detect later modification of the file.

It does not independently prove that the underlying evidence is truthful.

---

# 51. Evidence Checklist

```text
[ ] Target recorded
[ ] Authorization confirmed
[ ] Scope confirmed
[ ] Rules reviewed
[ ] Testing context recorded
[ ] Preconditions recorded
[ ] Reproduction documented
[ ] Expected behavior recorded
[ ] Actual behavior recorded
[ ] Relevant request captured
[ ] Relevant response captured
[ ] Sensitive information minimized
[ ] Secrets redacted
[ ] Timestamp recorded
[ ] Evidence organized
[ ] Finding ID assigned
[ ] Impact supported by evidence
```

---

# 52. 0.8 — Understanding Vulnerability Severity and Impact

## 52.1 Vulnerability vs Impact

A vulnerability describes a security weakness.

Impact describes what that weakness allows an attacker or unauthorized party to accomplish.

These are related but not identical.

Example:

```text
Vulnerability:
Missing object-level authorization.

Impact:
One user can access another user's test-controlled object.
```

The impact should be demonstrated rather than assumed.

---

# 53. Impact Categories

Security impact can involve:

### Confidentiality

Unauthorized access to information.

Examples:

* Private records
* Credentials
* Sensitive application data

### Integrity

Unauthorized modification of information or system state.

Examples:

* Changing another user's data
* Modifying configuration
* Altering transactions

### Availability

Interference with legitimate availability.

Examples:

* Service disruption
* Resource exhaustion

Testing availability-related issues requires particular care because destructive testing may be prohibited.

---

# 54. Authentication Impact

Authentication concerns establishing identity.

Questions include:

```text
Can an unauthenticated user access protected functionality?

Can authentication be bypassed?

Can one user's authentication state be used improperly?
```

Authentication findings must be evaluated based on what was actually demonstrated.

---

# 55. Authorization Impact

Authorization determines what an authenticated identity is allowed to do.

Questions include:

```text
Can User A access User B's object?

Can a normal user perform an administrative action?

Can one tenant access another tenant's data?
```

These issues often depend heavily on application context.

---

# 56. Business Impact

Technical behavior can have business consequences.

Examples:

```text
Unauthorized account access
Unauthorized transaction modification
Exposure of confidential records
Privilege escalation
Cross-tenant access
Sensitive administrative functionality
```

Do not automatically assign the highest possible impact.

Document the actual demonstrated consequence.

---

# 57. Preconditions

Severity depends partly on what an attacker must already possess.

Document requirements such as:

```text
Unauthenticated
Authenticated user
Specific account role
Special feature enabled
Victim interaction required
Specific object identifier required
```

The easier a condition is to satisfy, the different the practical risk may be compared with a condition requiring substantial privileges or unusual circumstances.

Do not turn this into an unsupported numerical score.

---

# 58. Attack Complexity

Consider:

```text
How many steps are required?

Does the attacker need special knowledge?

Are special conditions required?

Does exploitation depend on timing?

Does exploitation require another user's interaction?

```

Again, document the observed requirements rather than exaggerating them.

---

# 59. Severity Systems

Some programs use formal severity systems such as CVSS.

CVSS considers multiple dimensions of vulnerability characteristics and impact.

However:

> **A program's own severity policy takes precedence for that program's triage process.**

A CVSS-style assessment should not be treated as an automatic guarantee of:

* Acceptance
* Severity
* Reward
* Priority

---

# 60. Severity Inflation

Avoid statements such as:

```text
CRITICAL!!!
```

without evidence.

Instead:

```text
The demonstrated behavior allows an authenticated test account
to access another test account's object.
```

Then explain the security consequence.

Evidence first.

Severity conclusion second.

---

# 61. Impact Assessment Model

For this lab, use:

```text
Vulnerability
     ↓
Preconditions
     ↓
Security Boundary
     ↓
Observed Behavior
     ↓
Demonstrated Impact
     ↓
Potential Broader Impact
     ↓
Evidence
```

Clearly distinguish:

### Demonstrated

What was actually proven.

### Potential

What might be possible under additional conditions.

This distinction is critical.

---

# 62. Finding Record

Use a consistent structure:

```text
Finding ID:
F-001

Title:

Target:

Authorization:

Prerequisites:

Vulnerability:

Expected Behavior:

Actual Behavior:

Demonstrated Impact:

Potential Impact:

Reproduction:

Evidence:

Limitations:

Program Severity Guidance:

Status:
```

---

# 63. Reporting Standard

A professional report should be:

* Clear
* Reproducible
* Concise
* Evidence-based
* Respectful
* Scope-aware

Avoid:

* Unsupported claims
* Emotional language
* Exaggerated severity
* Unnecessary data
* Unrelated findings

---

# 64. Pre-Submission Checklist

```text
AUTHORIZATION
[ ] Target is authorized.

SCOPE
[ ] Asset is in scope.
[ ] Testing technique is permitted.

REPRODUCTION
[ ] Steps are complete.
[ ] Preconditions are documented.

EVIDENCE
[ ] Evidence demonstrates the behavior.
[ ] Sensitive information is minimized.
[ ] Secrets are redacted.

IMPACT
[ ] Demonstrated impact is clearly explained.
[ ] Potential impact is distinguished from demonstrated impact.
[ ] Severity is not exaggerated.

REPORT
[ ] Title is accurate.
[ ] Summary is clear.
[ ] Expected behavior is documented.
[ ] Actual behavior is documented.
[ ] Reproduction is documented.

SAFETY
[ ] No unnecessary destructive action was performed.
[ ] No unnecessary user data was accessed.
```

---

# 65. Professional Research Workflow

The complete Stage 0 methodology is:

```text
┌─────────────────────┐
│ 1. AUTHORIZATION    │
└──────────┬──────────┘
           ↓
┌─────────────────────┐
│ 2. SCOPE            │
└──────────┬──────────┘
           ↓
┌─────────────────────┐
│ 3. RULES            │
└──────────┬──────────┘
           ↓
┌─────────────────────┐
│ 4. RECONNAISSANCE   │
└──────────┬──────────┘
           ↓
┌─────────────────────┐
│ 5. ATTACK SURFACE   │
└──────────┬──────────┘
           ↓
┌─────────────────────┐
│ 6. HYPOTHESIS       │
└──────────┬──────────┘
           ↓
┌─────────────────────┐
│ 7. CONTROLLED TEST  │
└──────────┬──────────┘
           ↓
┌─────────────────────┐
│ 8. VALIDATION       │
└──────────┬──────────┘
           ↓
┌─────────────────────┐
│ 9. EVIDENCE         │
└──────────┬──────────┘
           ↓
┌─────────────────────┐
│ 10. IMPACT          │
└──────────┬──────────┘
           ↓
┌─────────────────────┐
│ 11. REPORT          │
└──────────┬──────────┘
           ↓
┌─────────────────────┐
│ 12. RETEST          │
└─────────────────────┘
```

---

# 66. Stage 0 Operating Rules

The Bug Bounty Lab follows these rules:

### Rule 1 — Authorization First

Never treat discovery as authorization.

### Rule 2 — Scope Before Tools

Know the target before testing it.

### Rule 3 — Rules Before Automation

Understand permitted testing methods before running automated tools.

### Rule 4 — Evidence Before Claims

Do not make claims that the evidence cannot support.

### Rule 5 — Minimal Impact

Use the smallest test that proves the behavior.

### Rule 6 — Protect Data

Minimize, redact, and protect sensitive information.

### Rule 7 — Reproducibility

Document enough information to reproduce the finding.

### Rule 8 — Version Everything Important

Use Git to preserve the development history of the lab.

### Rule 9 — Separate Learning From Target Data

Do not mix general curriculum material with program-specific sensitive information.

### Rule 10 — Never Inflate Impact

Distinguish demonstrated behavior from theoretical possibilities.

---

# 67. Stage 0 Templates

## 67.1 Program Intake

```text
# Program Intake

Program:
Organization:
Program URL:

Date Reviewed:

Scope Source:

In-Scope Assets:

Out-of-Scope Assets:

Testing Restrictions:

Authentication Requirements:

Automation Restrictions:

Reporting Channel:

Special Requirements:

Notes:
```

---

## 67.2 Scope Record

```text
# Scope Record

Asset:
Asset Type:
Scope Status:

Source:
Date Checked:

Permitted Testing:

Restricted Testing:

Notes:
```

---

## 67.3 Finding Record

```text
# F-001 — Finding Title

## Target

## Authorization

## Preconditions

## Vulnerability

## Expected Behavior

## Actual Behavior

## Reproduction

1.
2.
3.

## Demonstrated Impact

## Potential Impact

## Evidence

## Limitations

## Program Guidance

## Status
```

---

## 67.4 Evidence Record

```text
# Evidence Record

Evidence ID:

Finding:

Type:

Filename:

Captured:

Purpose:

Sensitive Information:

Redaction Applied:

Hash:

Notes:
```

---

## 67.5 Retest Record

```text
# Retest

Finding:

Original Issue:

Retest Date:

Original Reproduction:

Retest Procedure:

Observed Result:

Evidence:

Conclusion:

Status:
```

---

# 68. Stage 0 Practical Exercises

Stage 0 is not complete through reading alone.

The researcher should demonstrate the following.

## Exercise 1 — Program Analysis

Take an authorized practice or bug bounty program and identify:

```text
Program
In-scope assets
Out-of-scope assets
Testing restrictions
Reporting requirements
```

Do not begin vulnerability testing.

---

## Exercise 2 — Scope Matrix

Create:

```text
Asset | Scope | Testing Allowed | Restrictions | Notes
```

for the selected authorized program.

---

## Exercise 3 — Research Workspace

Create the BugBounty-lab directory structure.

Verify:

```bash
tree
```

or an equivalent directory listing.

---

## Exercise 4 — Git Workflow

Initialize or configure Git for the learning project.

Create meaningful commits for major foundation milestones.

Verify:

```bash
git status
git log --oneline
```

---

## Exercise 5 — Documentation

Create a sample finding using a controlled laboratory target.

Document:

```text
Target
Authorization
Reproduction
Expected behavior
Actual behavior
Evidence
Impact
```

---

## Exercise 6 — Evidence Handling

Create a harmless sample evidence file.

Generate its SHA-256 hash:

```bash
sha256sum evidence.txt
```

Modify the file and generate the hash again.

Observe that the hash changes.

---

## Exercise 7 — Impact Analysis

Take a hypothetical vulnerability and distinguish:

```text
Vulnerability
Prerequisites
Demonstrated impact
Potential impact
```

The objective is to learn not to exaggerate security consequences.

---

# 69. Stage 0 Completion Criteria

Stage 0 is complete only when the researcher can demonstrate:

### Understanding

```text
[ ] Explain bug bounty hunting.
[ ] Explain authorization.
[ ] Explain responsible disclosure.
[ ] Explain scope.
[ ] Explain rules of engagement.
```

### Environment

```text
[ ] BugBounty-lab structure exists.
[ ] Learning material is organized.
[ ] Target workspaces remain separate.
```

### Git

```text
[ ] Git repository is functional.
[ ] Commits are meaningful.
[ ] Sensitive files are protected.
[ ] History is understandable.
```

### Methodology

```text
[ ] Can follow the authorization gate.
[ ] Can verify scope.
[ ] Can form a testing hypothesis.
[ ] Can validate observations.
[ ] Can document findings.
```

### Evidence

```text
[ ] Can capture relevant HTTP evidence.
[ ] Can write reproduction steps.
[ ] Can redact sensitive information.
[ ] Can organize evidence.
```

### Impact

```text
[ ] Can distinguish vulnerability from impact.
[ ] Can distinguish demonstrated from potential impact.
[ ] Can identify security boundaries.
[ ] Can avoid severity inflation.
```

---

# 70. Stage 0 Deliverable

The completed Stage 0 environment should provide:

```text
A professional,
version-controlled,
documented,
repeatable,
scope-aware,
evidence-driven
Bug Bounty research environment.
```

The researcher should now have:

```text
Project Structure
      +
Authorization Model
      +
Program Understanding
      +
Git Workflow
      +
Documentation Standards
      +
Testing Methodology
      +
Evidence Standards
      +
Impact Analysis
```

---

# 71. Stage 0 → Stage 1 Transition

Stage 0 deliberately does **not** teach detailed web technologies.

The following belong to later stages:

* HTTP fundamentals
* HTTP methods
* Headers
* Cookies
* Sessions
* HTML
* JavaScript
* DOM
* URLs
* Browser behavior
* APIs
* Burp Suite
* Web vulnerability classes

Those topics begin in:

```text
01-Web-Foundations/
```

The purpose of Stage 0 is to establish **how we conduct research**.

Stage 1 will establish **how the web works**.

---

# 72. Final Stage 0 Model

The entire foundation can be summarized as:

```text
                BUG BOUNTY RESEARCH
                        │
                        ▼
              ┌───────────────────┐
              │ 0.1 UNDERSTAND    │
              │ Bug Bounty        │
              └─────────┬─────────┘
                        ▼
              ┌───────────────────┐
              │ 0.2 ACT ETHICALLY │
              │ & WITH AUTHORITY  │
              └─────────┬─────────┘
                        ▼
              ┌───────────────────┐
              │ 0.3 UNDERSTAND    │
              │ PROGRAMS & SCOPE  │
              └─────────┬─────────┘
                        ▼
              ┌───────────────────┐
              │ 0.4 BUILD THE     │
              │ RESEARCH PROJECT  │
              └─────────┬─────────┘
                        ▼
              ┌───────────────────┐
              │ 0.5 VERSION &     │
              │ DOCUMENT IT       │
              └─────────┬─────────┘
                        ▼
              ┌───────────────────┐
              │ 0.6 BUILD A       │
              │ REPEATABLE METHOD │
              └─────────┬─────────┘
                        ▼
              ┌───────────────────┐
              │ 0.7 PRESERVE      │
              │ EVIDENCE          │
              └─────────┬─────────┘
                        ▼
              ┌───────────────────┐
              │ 0.8 UNDERSTAND    │
              │ IMPACT & SEVERITY │
              └─────────┬─────────┘
                        ▼
                STAGE 0 COMPLETE
                        │
                        ▼
              01 — WEB FOUNDATIONS
```

---

# 73. Core Principles to Carry Forward

The following principles apply to every stage of the BugBounty-lab:

> **Authorization before action.**

> **Scope before testing.**

> **Rules before automation.**

> **Understand before exploiting.**

> **Observe before concluding.**

> **Validate before reporting.**

> **Evidence before claims.**

> **Minimal proof before maximum impact.**

> **Protect data.**

> **Document everything necessary, not everything possible.**

> **Separate demonstrated impact from theoretical impact.**

> **Use Git to preserve the history of the work.**

> **Keep learning material separate from sensitive target data.**

> **Discovery is not authorization.**

> **Reachability is not permission.**

> **A tool finding is not automatically a vulnerability.**

> **A vulnerability is not automatically critical.**

> **Professional security research is a disciplined process, not random tool usage.**

---

# 74. Stage 0 Status

```text
🔵 STAGE 0 — PROJECT FOUNDATION

0.1 Introduction to Bug Bounty Hunting          [DOCUMENTED]
0.2 Ethics, Authorization & Disclosure          [DOCUMENTED]
0.3 Understanding Bug Bounty Programs           [DOCUMENTED]
0.4 BugBounty-lab Project Setup                 [DOCUMENTED]
0.5 Git Workflow & Documentation Standards      [DOCUMENTED]
0.6 Professional Testing Methodology            [DOCUMENTED]
0.7 Evidence Collection & Organization          [DOCUMENTED]
0.8 Vulnerability Severity & Impact              [DOCUMENTED]

Status: FOUNDATION DOCUMENT COMPLETE

Next Stage:
01 — Web Foundations
```

---

# 75. Final Statement

The purpose of Stage 0 is not to make the researcher immediately capable of finding vulnerabilities.

Its purpose is to establish the discipline required to do security research professionally.

The researcher should leave Stage 0 knowing:

```text
WHAT I am allowed to test.
WHERE I am allowed to test.
HOW I am allowed to test.
HOW I will document what I discover.
HOW I will preserve evidence.
HOW I will communicate a finding.
HOW I will reason about its impact.
```

Only after those foundations are established should technical web security training begin.

**Stage 0 is the operating system for the rest of the BugBounty-lab.**
