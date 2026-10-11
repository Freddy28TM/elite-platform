# 🔵 STAGE 1.1 — HOW THE WEB WORKS

## Professional Web Security Fundamentals

---

# 1. Lesson Overview

Understanding how the web works is the foundation for understanding web application security.

A security researcher should not begin with a payload or vulnerability name.

The first question should be:

> **What is the application actually doing?**

A modern web application is composed of multiple interacting components.

A simplified model is:

```text
User
  ↓
Browser
  ↓
DNS
  ↓
Network
  ↓
CDN / Reverse Proxy / Web Server
  ↓
Application
  ↓
Database / External Services
  ↓
Application
  ↓
Web Infrastructure
  ↓
Browser
  ↓
HTML / CSS / JavaScript
```

This lesson establishes the basic concepts required to understand that communication flow.

---

# 2. Learning Objectives

By completing this lesson, the researcher should be able to:

* Explain the client/server model.
* Explain what a browser does.
* Explain the basic web request/response lifecycle.
* Understand the role of DNS.
* Distinguish domain names from IP addresses.
* Understand IPv4 and IPv6 at a basic level.
* Understand the purpose of network ports.
* Understand the relationship between HTTPS and port 443.
* Recognize that CDNs and reverse proxies can sit between clients and origin servers.
* Understand that an observed IP address does not necessarily identify an origin server.
* Distinguish observed facts from assumptions.
* Understand why reachability does not establish authorization.

---

# 3. The Client/Server Model

The fundamental web communication model is:

```text
CLIENT                         SERVER
  │                              │
  │────── Request ──────────────>│
  │                              │
  │<───── Response ──────────────│
  │                              │
```

## 3.1 Client

A client is a system or application that initiates communication with a server.

In ordinary web browsing, the browser acts as the client.

Examples include:

* Firefox
* Chrome
* Chromium
* Safari
* Mobile applications
* API clients
* `curl`
* Programs written in Python or other languages

For example:

```bash
curl https://example.com
```

Here, `curl` is acting as an HTTP client.

## 3.2 Server

A server is a system that receives requests and provides responses or services.

A web application may contain several server-side components:

```text
                    SERVER SIDE

              ┌──────────────────┐
              │ CDN / Reverse    │
              │ Proxy / Web      │
              │ Server           │
              └────────┬─────────┘
                       │
                       ▼
              ┌──────────────────┐
              │ Application      │
              │ Server           │
              └────────┬─────────┘
                       │
                       ▼
              ┌──────────────────┐
              │ Database /       │
              │ External         │
              │ Services         │
              └──────────────────┘
```

The exact architecture varies between applications.

---

# 4. Basic Web Request Lifecycle

A simplified request lifecycle is:

```text
User
 │
 ▼
Browser
 │
 │ Request
 ▼
Web Infrastructure
 │
 ▼
Application
 │
 ▼
Database / Services
 │
 ▼
Application
 │
 ▼
Web Infrastructure
 │
 │ Response
 ▼
Browser
 │
 ▼
Rendered Content
```

For example, when a user requests:

```text
https://example.com/profile
```

the browser eventually sends a request for the requested resource.

The application may then:

1. Receive the request.
2. Identify the requested resource.
3. Determine the user's identity if applicable.
4. Check authorization where required.
5. Retrieve or process data.
6. Generate a response.
7. Return the response to the client.

The browser then processes the response.

---

# 5. The Browser Is Only One Component

A common beginner mistake is to think:

```text
Browser = Website
```

A better mental model is:

```text
Browser
   │
   │ HTTP(S)
   ▼
Web Infrastructure
   │
   ▼
Application
   │
   ▼
Data / Services
```

The browser is a client.

The complete web application exists across multiple components.

This distinction becomes important when studying vulnerabilities.

For example:

### Authentication

```text
Who is the user?
```

### Authorization

```text
What is this user allowed to access?
```

### XSS

```text
Where does user-controlled data enter?
Where is it processed?
Where does it become browser-interpreted content?
```

### Access Control

```text
Where does the application enforce ownership or permissions?
```

### SSRF

```text
Does a server-side component make a request based on data supplied by the client?
```

These questions depend on understanding the underlying architecture.

---

# 6. Practical Exercise 1 — Observing a Browser Request

## Environment

* Operating system: Parrot Security OS
* Browser: Mozilla Firefox
* Target: `https://example.com/`
* Activity: Passive observation using browser Developer Tools
* Testing type: Non-destructive observation

The browser's Network Developer Tools were used to observe the request generated when loading the page.

---

# 7. Observed HTTP Request

The observed request contained the following information:

| Field          | Observed Value       |
| -------------- | -------------------- |
| Method         | `GET`                |
| Scheme         | `https`              |
| Host           | `example.com`        |
| Path           | `/`                  |
| Address        | `172.66.147.243:443` |
| Status         | `304`                |
| Protocol       | HTTP/2               |
| DNS Resolution | System               |

The browser requested the root resource:

```text
https://example.com/
```

using HTTPS.

---

# 8. Observed Request Headers

Several request headers were observed.

## Host

```http
Host: example.com
```

Identifies the requested host.

## User-Agent

```http
User-Agent: Mozilla/5.0 ...
```

Identifies characteristics of the client software.

## Accept

```http
Accept: text/html,application/xhtml+xml,...
```

Indicates response media types the browser can accept.

## Accept-Encoding

```http
Accept-Encoding: gzip, deflate, br, zstd
```

Indicates supported content encodings.

## If-Modified-Since

```http
If-Modified-Since: Tue, 15 Sep 2026 23:41:26 GMT
```

This indicates that the browser had a cached representation and was asking whether the resource had changed since the specified time.

## Sec-Fetch-Dest

```http
Sec-Fetch-Dest: document
```

Indicates that the request was for a document.

## Sec-Fetch-Mode

```http
Sec-Fetch-Mode: navigate
```

Indicates that the request was associated with navigation.

---

# 9. Observed Response Headers

The response included:

```http
Age: 6985
Allow: GET, HEAD
CF-Cache-Status: HIT
CF-Ray: ...
ETag: "6aa9d7a6-22f"
Last-Modified: Tue, 15 Sep 2026 23:41:26 GMT
Server: cloudflare
```

These headers provided useful information about caching and intermediary infrastructure.

---

# 10. Understanding HTTP 304

The response status was:

```text
304 Not Modified
```

The browser had sent:

```http
If-Modified-Since: Tue, 15 Sep 2026 23:41:26 GMT
```

The server determined that the cached representation could still be used.

The browser therefore reused its cached copy instead of receiving a new representation of the resource.

A simplified flow is:

```text
Browser
 │
 │ "I have a cached copy."
 │
 │ If-Modified-Since
 ▼
Server
 │
 │ "It has not changed."
 │
 │ 304 Not Modified
 ▼
Browser
 │
 ▼
Use cached representation
```

---

# 11. ETag and Last-Modified

The response included:

```http
ETag: "6aa9d7a6-22f"
```

An ETag is a validator associated with a particular representation of a resource.

The response also included:

```http
Last-Modified: Tue, 15 Sep 2026 23:41:26 GMT
```

This provides a timestamp associated with the resource's modification state.

These mechanisms can be used by clients and servers to support conditional requests and caching.

---

# 12. CDN and Reverse Proxy Observation

The response included:

```http
Server: cloudflare
CF-Cache-Status: HIT
```

This indicates that Cloudflare infrastructure was involved in handling the request.

A simplified architecture could therefore look like:

```text
Browser
   │
   ▼
DNS
   │
   ▼
Cloudflare Edge
   │
   ▼
Origin Infrastructure
   │
   ▼
Application
```

The exact internal architecture cannot be determined from these headers alone.

---

# 13. Important Security Observation

The browser observed:

```text
172.66.147.243:443
```

It would be incorrect to automatically conclude:

```text
172.66.147.243 = origin server
```

A CDN or reverse proxy can expose its own network address while forwarding requests to another system.

Therefore:

```text
Observed IP
≠
Automatically confirmed origin IP
```

This is an important reconnaissance principle.

---

# 14. Observed Facts vs Assumptions

Security research requires separating evidence from inference.

## Observed

The browser showed:

* HTTPS
* HTTP/2
* `example.com`
* `172.66.147.243:443`
* `304 Not Modified`
* Cloudflare-related headers
* Cache-related headers
* System DNS resolution

## Not established

The observation did not establish:

* The origin server's IP address.
* The backend programming language.
* The backend framework.
* The database technology.
* The internal network architecture.
* The application's complete request path.

This distinction prevents unsupported conclusions.

---

# 15. DNS Fundamentals

DNS stands for:

> Domain Name System

DNS provides a naming system that allows applications to resolve domain names into network information.

A simplified example is:

```text
example.com
     │
     ▼
DNS resolution
     │
     ▼
IP address
```

A domain can resolve to multiple addresses.

DNS is therefore an important part of the web request lifecycle.

---

# 16. Common DNS Record Types

| Record  | Purpose                        |
| ------- | ------------------------------ |
| `A`     | IPv4 address                   |
| `AAAA`  | IPv6 address                   |
| `CNAME` | Alias to another domain name   |
| `MX`    | Mail-server information        |
| `TXT`   | Text-based information         |
| `NS`    | Name-server information        |
| `SOA`   | Start of Authority information |

This lesson focuses primarily on `A`, `AAAA`, and `CNAME`.

---

# 17. IPv4 Addresses

An IPv4 address identifies a destination within an IPv4 network.

Example:

```text
172.66.147.243
```

IPv4 uses four numerical components.

A domain may have multiple IPv4 addresses.

---

# 18. IPv6 Addresses

IPv6 provides a much larger address space than IPv4.

An example IPv6 address is:

```text
2606:4700:10::ac42:93f3
```

IPv6 addresses are represented using hexadecimal notation.

DNS uses `AAAA` records for IPv6 addresses.

---

# 19. Practical Exercise 2 — DNS Observation

The following commands were used against `example.com`:

```bash
dig example.com A
```

```bash
dig example.com AAAA
```

```bash
dig example.com CNAME
```

```bash
getent ahosts example.com
```

These commands were used only for passive DNS observation.

---

# 20. A Record Results

The `A` query returned:

```text
104.20.23.154
172.66.147.243
```

The observed TTL was:

```text
28 seconds
```

Therefore, the domain returned two IPv4 addresses in this DNS response.

The result demonstrated that a single domain name can resolve to multiple IPv4 addresses.

---

# 21. AAAA Record Results

The `AAAA` query returned:

```text
2606:4700:10::ac42:93f3
2606:4700:10::6814:179a
```

These are IPv6 addresses.

The first query attempt timed out:

```text
communications error to 1.1.1.1#53: timed out
```

The subsequent query succeeded.

This demonstrates an important troubleshooting principle:

> A temporary DNS timeout does not necessarily mean that a domain or service is unavailable.

It can be caused by transient network or resolver conditions.

---

# 22. CNAME Result

The CNAME query returned:

```text
status: NOERROR
ANSWER: 0
```

No CNAME record was returned in the answer section.

The response contained an SOA record associated with the authoritative DNS infrastructure.

The important distinction is:

```text
No CNAME answer
≠
No DNS records
```

The domain had already returned valid `A` and `AAAA` records.

---

# 23. SOA Observation

The CNAME query returned an SOA record containing authoritative DNS information.

The observed names included:

```text
elliott.ns.cloudflare.com.
dns.cloudflare.com.
```

This provides information about the authoritative DNS infrastructure.

It does not by itself reveal the application's origin server.

---

# 24. `dig` vs `getent`

Two different approaches were used.

## `dig`

`dig` is primarily used to query DNS records directly.

Example:

```bash
dig example.com A
```

## `getent ahosts`

`getent ahosts` uses the system's configured name-resolution mechanisms.

Example:

```bash
getent ahosts example.com
```

The output showed both IPv4 and IPv6 addresses.

It also displayed:

```text
STREAM
DGRAM
RAW
```

These are socket classifications associated with the returned address information.

They do not represent three different IP addresses.

---

# 25. DNS Observation Results

The combined observations were:

```text
Domain:
example.com

IPv4:
104.20.23.154
172.66.147.243

IPv6:
2606:4700:10::ac42:93f3
2606:4700:10::6814:179a

CNAME:
No CNAME record returned in the query.

System resolver:
Returned both IPv4 and IPv6 addresses.
```

---

# 26. Domain Names, IP Addresses, and Ports

These concepts should not be confused.

For:

```text
https://example.com/
```

the components are:

| Component  | Value                            |
| ---------- | -------------------------------- |
| Scheme     | `https`                          |
| Hostname   | `example.com`                    |
| Port       | `443` by default for HTTPS       |
| Path       | `/`                              |
| IP address | Obtained through name resolution |

The hostname appears in the URL.

The IP address is resolved separately.

---

# 27. Network Ports

A port identifies a service endpoint associated with a host.

Common associations include:

|   Port | Common Association |
| -----: | ------------------ |
|   `80` | HTTP               |
|  `443` | HTTPS              |
|   `22` | SSH                |
|   `53` | DNS                |
|   `25` | SMTP               |
| `3306` | MySQL              |
| `5432` | PostgreSQL         |

These are conventional associations, not guarantees.

A service can operate on a different port.

---

# 28. HTTPS and Port 443

The observed request used:

```text
https
```

and connected to:

```text
172.66.147.243:443
```

Port `443` is the conventional port associated with HTTPS.

This can be represented as:

```text
Scheme:
https

Host:
example.com

Destination:
172.66.147.243

Port:
443
```

The scheme, hostname, IP address, and port are related but distinct concepts.

---

# 29. CDN and Reverse Proxy Architecture

A modern web application may use infrastructure such as:

* CDN
* Reverse proxy
* Load balancer
* Web server
* Application server
* Database
* External APIs

A simplified architecture is:

```text
                  INTERNET

                     │
                     ▼
                DNS Resolution
                     │
                     ▼
              CDN / Reverse Proxy
                     │
                     ▼
                Load Balancer
                     │
                     ▼
                 Web Server
                     │
                     ▼
              Application Server
                     │
              ┌──────┴──────┐
              ▼             ▼
          Database      External API
```

Real architectures can be significantly more complex.

---

# 30. Security-Relevant Mental Model

When examining a web application, ask:

```text
Who is communicating?
        ↓
What is being requested?
        ↓
Where is the request going?
        ↓
What data is being transmitted?
        ↓
How is identity represented?
        ↓
Where is authorization enforced?
        ↓
Where is the data processed?
        ↓
What components can be trusted?
        ↓
Where does trust change?
```

This mental model will become increasingly important in later stages.

---

# 31. Authorization Boundary

An important lesson from this exercise is:

```text
Reachability ≠ Authorization
```

Being able to resolve a domain or connect to an IP address does not establish permission to test it.

Likewise:

```text
DNS result ≠ Permission
IP address ≠ Permission
HTTP response ≠ Permission
Public accessibility ≠ Permission
```

Authorization must come from the applicable program scope, rules, or another explicit authorization mechanism.

---

# 32. Security Researcher Mental Model

A researcher should distinguish:

```text
What I observed
        ↓
What I can verify
        ↓
What I infer
        ↓
What remains unknown
```

For example:

### Observed

```text
example.com resolved to multiple addresses.
```

### Observed

```text
The HTTP response contained Cloudflare-related headers.
```

### Reasonable inference

```text
Cloudflare infrastructure appears to be involved.
```

### Not established

```text
The observed IP is definitely the origin server.
```

That last statement requires additional evidence.

---

# 33. Lesson Takeaways

The most important concepts from this lesson are:

1. A browser is a client.
2. A web application consists of multiple interacting components.
3. HTTP provides request/response communication between clients and servers.
4. DNS translates domain names into network information.
5. A domain can resolve to multiple IPv4 and IPv6 addresses.
6. `A` records represent IPv4 addresses.
7. `AAAA` records represent IPv6 addresses.
8. A missing CNAME answer does not mean that a domain has no DNS records.
9. Ports identify service endpoints.
10. HTTPS conventionally uses port `443`.
11. CDNs and reverse proxies can sit between clients and origin infrastructure.
12. An observed IP address does not automatically identify an origin server.
13. Headers can provide useful architectural clues but rarely reveal the complete architecture.
14. Observations must be separated from assumptions.
15. Reachability does not establish authorization.

---

# 34. Lesson Verification

The researcher should now be able to answer:

### Question 1

What is the difference between a client and a server?

### Question 2

What happens at a high level after entering a URL into a browser?

### Question 3

What does DNS do?

### Question 4

What is the difference between an A record and an AAAA record?

### Question 5

What is a port?

### Question 6

Why did the browser connect to port 443?

### Question 7

What does HTTP `304 Not Modified` indicate?

### Question 8

Why should an observed IP address not automatically be considered the origin server?

### Question 9

What is the difference between `dig` and `getent ahosts`?

### Question 10

Why does discovering a reachable service not establish permission to test it?

---

# 35. Practical Research Workflow Established

The lesson establishes the following workflow:

```text
Observe
   ↓
Identify the component
   ↓
Understand its role
   ↓
Record evidence
   ↓
Separate facts from assumptions
   ↓
Verify
   ↓
Document
```

This workflow should continue throughout the BugBounty-lab.

---

# 36. Completion Criteria

Lesson 1.1 is complete when the researcher can:

* Explain client/server architecture without relying on memorized definitions.
* Trace a basic browser request.
* Identify the major components involved in a web request.
* Explain the basic purpose of DNS.
* Distinguish domain names, IP addresses, and ports.
* Explain IPv4 and IPv6 at a basic level.
* Explain the role of CDNs and reverse proxies.
* Explain why an edge IP does not necessarily identify an origin.
* Distinguish HTTP response status from application behavior.
* Separate observed facts from assumptions.
* Explain why authorization must come from explicit scope rather than technical accessibility.

---

# 37. Final Lesson Statement

The web should not be viewed as:

```text
Browser → Website
```

A more useful security model is:

```text
User
 ↓
Browser
 ↓
DNS
 ↓
Network
 ↓
CDN / Reverse Proxy / Web Server
 ↓
Application
 ↓
Database / Services
 ↓
Application
 ↓
Web Infrastructure
 ↓
Browser
 ↓
Rendered Application
```

Understanding this communication chain is essential before studying how applications fail.

The objective of web security research is not simply to find unusual requests.

It is to understand:

```text
Architecture
 ↓
Communication
 ↓
Identity
 ↓
State
 ↓
Trust
 ↓
Authorization
 ↓
Data Flow
 ↓
Application Behavior
```

Only after understanding these layers does vulnerability-specific testing become meaningful.

**Lesson 1.1 establishes the first technical foundation for the BugBounty-lab.**
