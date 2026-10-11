

## Part 1 — HTTP as the Web Communication Protocol

### 1. Concept

HTTP stands for **Hypertext Transfer Protocol**.

It is an application-layer protocol used for communication between clients and servers on the web.

The simplified communication model is:

```text
Client
   │
   │ HTTP Request
   ▼
Server
   │
   │ HTTP Response
   ▼
Client
```

A client may be a browser, command-line tool, mobile application, or another software component.

A server receives the request, processes it, and returns a response.

HTTP defines the rules and semantics for this application-layer communication.

It does not itself provide:

* DNS resolution
* IP addressing
* TCP transport
* TLS encryption
* HTML rendering
* JavaScript execution

These are separate components of the overall web communication process.

### 2. Layered Mental Model

A useful simplified model is:

```text
Application
    │
    │ HTTP
    ▼
Transport
    │
    │ TCP / QUIC
    ▼
Network
    │
    │ IP
    ▼
Network Infrastructure
```

For HTTPS, TLS provides encryption and server authentication around the HTTP communication.

A simplified HTTPS sequence is:

```text
DNS resolution
      ↓
Network connection
      ↓
TLS handshake
      ↓
HTTP protocol negotiation
      ↓
HTTP request
      ↓
HTTP response
```

### 3. Example HTTP Request

A simplified HTTP request can look like:

```http
GET / HTTP/1.1
Host: example.com
```

The request contains a method, target resource, protocol version, and headers.

### 4. Example HTTP Response

A simplified response can look like:

```http
HTTP/1.1 200 OK
Content-Type: text/html
```

The response contains a status code, headers, and potentially a response body.

### 5. Practical Observation

The following command was used:

```bash
curl -sS -o /dev/null -w 'HTTP version: %{http_version}nStatus: %{http_code}nContent type: %{content_type}nRemote IP: %{remote_ip}nRemote port: %{remote_port}n' https://example.com/
```

Observed result:

```text
HTTP version: 2
Status: 200
Content type: text/html
Remote IP: 172.66.147.243
Remote port: 443
```

### 6. Observation Analysis

The output establishes several concrete facts.

#### HTTP version

```text
HTTP version: 2
```

The request was completed using **HTTP/2**.

This confirms that the connection successfully negotiated HTTP/2 rather than HTTP/1.1.

#### HTTP status

```text
Status: 200
```

The server-side HTTP response indicated successful processing of the request.

`200 OK` means the requested resource was successfully returned.

#### Content type

```text
Content type: text/html
```

The response was identified as HTML content.

This is consistent with `example.com` serving a web document.

#### Remote IP

```text
Remote IP: 172.66.147.243
```

The connection reached this IPv4 address.

This is an important distinction:

> An observed remote IP is not automatically the origin server.

A web application may be positioned behind a CDN, reverse proxy, load balancer, or other intermediary.

Therefore, the IP should be documented as the **observed remote endpoint**, rather than automatically identifying it as the origin infrastructure.

#### Remote port

```text
Remote port: 443
```

The connection was established to port `443`.

Port 443 is commonly used for HTTPS.

### 7. Complete Observed Communication Chain

Combining the previous observations with this exercise produces the following mental model:

```text
example.com
     │
     │ DNS
     ▼
IPv4 / IPv6 addresses
     │
     │ Network connection
     ▼
Remote endpoint
     │
     │ Port 443
     ▼
TLS
     │
     │ ALPN negotiation
     ▼
HTTP/2
     │
     │ HTTP request
     ▼
HTTP response
     │
     ├── Status: 200
     └── Content-Type: text/html
```

### 8. Security Researcher Observation

This exercise demonstrates why a security researcher should separate different layers of the web stack.

For example:

```text
Domain name
     ≠
IP address
     ≠
Origin server
     ≠
Application
     ≠
HTTP endpoint
```

Likewise:

```text
Reachability
     ≠
Authorization
```

Being able to resolve or connect to an endpoint does not establish permission to test it.

For authorized security testing, authorization and scope must always be established independently.

### 9. Part 1 Verification

The following facts were directly observed during the exercise:

* `example.com` was reachable over HTTPS.
* The connection used HTTP/2.
* The HTTP response status was `200`.
* The content type was `text/html`.
* The observed remote IPv4 address was `172.66.147.243`.
* The observed remote port was `443`.

These observations are sufficient to verify the basic HTTP communication model introduced in this part.

### 10. Key Takeaway

HTTP is the application-layer protocol through which web clients and servers exchange requests and responses.

A practical web-security workflow therefore requires understanding not only the HTTP messages themselves, but also the network and protocol layers that support them:

```text
DNS
 ↓
IP
 ↓
TCP / QUIC
 ↓
TLS
 ↓
HTTP
 ↓
Application
```

Understanding these layers provides the foundation for later lessons involving requests, responses, headers, cookies, sessions, authentication, authorization, APIs, proxies, and vulnerabilities.
## Part 2 — HTTP Request Structure

### 1. Request Structure

An HTTP request consists of several logical components:

```text
HTTP Request
│
├── Request Line
│   ├── Method
│   ├── Request Target
│   └── HTTP Version
│
├── Headers
│
├── Blank Line
│
└── Optional Request Body
```

Not every request contains a body.

For example, a simple HTTP/1.1 request can look like:

```http
GET / HTTP/1.1
Host: example.com
User-Agent: curl/8.21.0
Accept: */*

```

The blank line after the headers separates the request headers from a possible request body.

### 2. Controlled Observation

The following command was used:

```bash
curl -sv --http1.1 -o /dev/null https://example.com/ 2>&1
```

The options have the following purposes:

* `-s` enables silent mode for normal progress output.
* `-v` enables verbose protocol and connection information.
* `--http1.1` requests HTTP/1.1.
* `-o /dev/null` discards the response body.
* `2>&1` combines verbose output from standard error with standard output.

The purpose of this observation was to isolate the HTTP request and response metadata without displaying the HTML response body.

### 3. Observed Request

The request sent by curl was:

```http
GET / HTTP/1.1
Host: example.com
User-Agent: curl/8.21.0
Accept: */*

```

Curl marks outgoing request lines with `>` in verbose mode:

```text
> GET / HTTP/1.1
> Host: example.com
> User-Agent: curl/8.21.0
> Accept: */*
>
```

The `>` marker represents data sent from the client toward the server.

### 4. Request Line

The first line was:

```http
GET / HTTP/1.1
```

It contains three important components:

```text
GET       → Method
/         → Request target
HTTP/1.1  → HTTP version
```

#### Method

```text
GET
```

`GET` indicates that the client is requesting a resource.

In this observation, the client requested the root resource.

#### Request Target

```text
/
```

The `/` represents the root path of the requested host.

The complete URL was:

```text
https://example.com/
```

The request target shown in the HTTP/1.1 request was:

```text
/
```

#### HTTP Version

```text
HTTP/1.1
```

The request explicitly used HTTP/1.1 because the command included:

```bash
--http1.1
```

### 5. Host Header

The request contained:

```http
Host: example.com
```

The `Host` header identifies the hostname being requested.

This is important because multiple hostnames can potentially be served through the same network endpoint.

A useful mental model is:

```text
Network endpoint
       │
       ├── Host A
       ├── Host B
       └── Host C
```

The HTTP request can identify which hostname the client intends to access.

For security research, this distinction is important:

```text
IP address
    ≠
hostname
    ≠
application
```

An IP address observed during testing should therefore not automatically be treated as the identity of the web application or its origin infrastructure.

### 6. User-Agent Header

The request contained:

```http
User-Agent: curl/8.21.0
```

The `User-Agent` header identifies the client software making the request.

In this observation, the client was:

```text
curl/8.21.0
```

Different clients may send different `User-Agent` values.

Browsers, command-line clients, mobile applications, and automated software can therefore produce different request headers.

### 7. Accept Header

The request contained:

```http
Accept: */*
```

The `Accept` header communicates which response media types the client is willing to receive.

The value:

```text
*/*
```

means that the client accepts any media type.

### 8. Blank Line

After the final request header, the verbose output showed:

```text
> Accept: */*
>
```

The empty line is structurally significant.

It separates the request headers from an optional request body.

The observed request therefore had this structure:

```text
Request Line
     ↓
Headers
     ↓
Blank Line
     ↓
No request body observed
```

### 9. No Request Body

The observed `GET` request did not contain a request body.

This should be documented as an observation rather than generalized into a statement that GET requests can never have bodies.

The important distinction is:

```text
This request had no body
```

rather than:

```text
GET requests can never have bodies
```

Security research requires this kind of precise distinction between an observed behavior and a universal claim.

### 10. Observed Response

The server response began with:

```http
HTTP/1.1 200 OK
```

Curl represents incoming response lines with `<`:

```text
< HTTP/1.1 200 OK
< Date: ...
< Content-Type: text/html
< Transfer-Encoding: chunked
< Connection: keep-alive
< Server: cloudflare
```

The `<` marker therefore represents data received from the server.

### 11. Request and Response Direction

The verbose output provides a useful mental model:

```text
Client
  │
  │ > HTTP Request
  │
  ▼
Server / intermediary
  │
  │ < HTTP Response
  │
  ▼
Client
```

More specifically:

```text
> = client → server
< = server → client
```

This distinction will become especially useful when inspecting traffic in Burp Suite.

### 12. Connection Sequence

The complete observed sequence was:

```text
DNS resolution
      ↓
IPv6 connection attempt
      ↓
IPv4 connection
      ↓
TLS 1.3 handshake
      ↓
ALPN negotiation
      ↓
HTTP/1.1
      ↓
GET request
      ↓
HTTP/1.1 response
```

The output showed:

```text
* ALPN: curl offers http/1.1
```

followed by:

```text
* ALPN: server accepted http/1.1
```

The TLS connection was therefore established before the HTTP/1.1 request was sent.

### 13. Observed Remote Endpoint

The connection was established to:

```text
172.66.147.243:443
```

The response also contained:

```http
Server: cloudflare
```

This provides evidence that Cloudflare was present in the observed request path.

However, the observation does **not** establish that `172.66.147.243` is the origin server.

The correct documentation is:

```text
Observed:
The connection reached 172.66.147.243 on port 443.

Observed:
The response contained Server: cloudflare.

Not established:
172.66.147.243 is the origin server.
```

### 14. Multiple Resolved Addresses

The command also showed multiple addresses during DNS resolution:

```text
IPv4:
172.66.147.243
104.20.23.154

IPv6:
2606:4700:10::6814:179a
2606:4700:10::ac42:93f3
```

The connection selected:

```text
172.66.147.243:443
```

This demonstrates that DNS can provide multiple possible network addresses for a hostname.

It also demonstrates why a single connection observation should not automatically be treated as the complete infrastructure picture.

### 15. Security Researcher Mental Model

A useful layered distinction is:

```text
Hostname
    ↓
DNS records
    ↓
Network endpoint
    ↓
TLS
    ↓
HTTP
    ↓
Application
    ↓
Application functionality
```

Each layer provides different information.

For example:

```text
DNS resolution
    ≠
authorization

Network reachability
    ≠
authorization

HTTP response
    ≠
permission to test further functionality
```

Authorization and program scope must always be established independently.

### 16. Part 2 Verification

The following facts were directly observed:

* The request used HTTP/1.1.
* The request method was `GET`.
* The request target was `/`.
* The `Host` header was `example.com`.
* The `User-Agent` identified curl version `8.21.0`.
* The `Accept` header was `*/*`.
* The request ended with a blank line.
* No request body was observed.
* The response status was `200 OK`.
* The response content type was `text/html`.
* The observed connection endpoint was `172.66.147.243:443`.
* The response contained `Server: cloudflare`.
* Multiple IPv4 and IPv6 addresses were returned during DNS resolution.

### 17. Key Takeaway

An HTTP request is structured data rather than simply a URL being sent to a server.

The basic HTTP/1.1 request observed in this exercise can be represented as:

```text
Request Line
     │
     ├── Method
     ├── Request Target
     └── HTTP Version
     │
     ▼
Headers
     │
     ▼
Blank Line
     │
     ▼
Optional Body
```

Being able to identify these components precisely is foundational for later work involving:

* request manipulation
* authentication
* authorization
* cookies
* parameters
* APIs
* Burp Suite
* access-control testing
* input validation
* vulnerability validation

The goal is not merely to recognize HTTP syntax, but to understand what each component means and what can legitimately be concluded from an observation.
## Part 3 — HTTP Response Structure

An HTTP response is the message sent from the server or an intermediary back to the client after processing an HTTP request.

A simplified response structure is:

```text
HTTP Response
│
├── Status Line
│   ├── HTTP Version
│   ├── Status Code
│   └── Reason Phrase
│
├── Response Headers
│
├── Blank Line
│
└── Optional Response Body
```

### 3.1 Controlled Observation

The response was observed using:

```bash
curl -sv --http1.1 -o /dev/null https://example.com/ 2>&1
```

The request was sent using HTTP/1.1.

The relevant response section was:

```http
< HTTP/1.1 200 OK
< Date: Fri, 18 Sep 2026 15:45:03 GMT
< Content-Type: text/html
< Transfer-Encoding: chunked
< Connection: keep-alive
< Server: cloudflare
< last-modified: Tue, 15 Sep 2026 23:38:37 GMT
< allow: GET, HEAD
< Accept-Ranges: bytes
< Age: 2170
< cf-cache-status: HIT
< CF-RAY: a3d179bf6e8de23e-MRS
<
```

The `<` marker in curl's verbose output represents data received from the server.

The blank line after the headers separates the response headers from the optional response body.

### 3.2 Status Line

The first line of the response was:

```http
HTTP/1.1 200 OK
```

The status line contains three conceptual components:

```text
HTTP/1.1    200    OK
   │         │      │
version    status  reason
```

#### HTTP Version

```text
HTTP/1.1
```

This identifies the HTTP protocol version used for the exchange.

The request explicitly selected HTTP/1.1 using:

```bash
--http1.1
```

and the server accepted HTTP/1.1 through ALPN.

#### Status Code

```text
200
```

The `200` status code indicates that the request was successfully processed.

A status code must be interpreted in the context of the request that produced it.

A `200` response by itself does not establish that a resource is sensitive, authorized for a particular user, or vulnerable.

#### Reason Phrase

```text
OK
```

`OK` is the textual reason phrase associated with the response status.

The numeric status code is the important machine-readable component.

### 3.3 Response Headers

After the status line, the server returned several headers.

For example:

```http
Content-Type: text/html
```

This identifies the media type of the response representation.

The response also contained:

```http
Transfer-Encoding: chunked
```

This indicates that the HTTP/1.1 response body was transferred using chunked transfer coding.

The following header was also observed:

```http
Connection: keep-alive
```

This indicates that the HTTP/1.1 connection could remain available for additional communication instead of necessarily being closed immediately after the response.

The response identified:

```http
Server: cloudflare
```

This provides information about the responding infrastructure layer.

However, this header does not prove that Cloudflare is the origin server.

### 3.4 Cache-Related Headers

The response included:

```http
last-modified: Tue, 15 Sep 2026 23:38:37 GMT
Age: 2170
cf-cache-status: HIT
```

`last-modified` provides a modification timestamp associated with the response representation.

`Age` indicates the approximate age of the cached response.

The observed:

```text
cf-cache-status: HIT
```

indicates that Cloudflare served the response from its cache.

This reinforces the infrastructure lesson from Part 1:

```text
Requested Hostname
       │
       ▼
Intermediary / CDN
       │
       ▼
Possible Origin
```

The remote IP observed by the client does not automatically identify the origin infrastructure.

### 3.5 Blank Line

The response ended its header section with a blank line:

```http
< CF-RAY: a3d179bf6e8de23e-MRS
<
```

The blank line separates the response headers from the optional response body.

Conceptually:

```text
HTTP/1.1 200 OK
Header: value
Header: value
Header: value

Response body
```

### 3.6 Response Body

The command used:

```bash
-o /dev/null
```

Therefore curl discarded the response body rather than displaying it.

The verbose output nevertheless showed that response data was received.

The earlier request without `-o /dev/null` showed that the response body was HTML, consistent with:

```http
Content-Type: text/html
```

### 3.7 Successful Response Versus Missing Resource

A second controlled request was performed against a deliberately nonexistent path:

```bash
curl -sv --http1.1 -o /dev/null https://example.com/this-path-should-not-exist-12345 2>&1
```

The request target changed to:

```http
GET /this-path-should-not-exist-12345 HTTP/1.1
Host: example.com
User-Agent: curl/8.21.0
Accept: */*
```

The response was:

```http
HTTP/1.1 404 Not Found
Date: Fri, 18 Sep 2026 15:46:12 GMT
Content-Type: text/html
Transfer-Encoding: chunked
Connection: keep-alive
Server: cloudflare
Age: 3639
cf-cache-status: HIT
CF-RAY: a3d17b6e2a2b89c7-MRS
```

The important difference was:

```text
/
    ↓
200 OK
```

versus:

```text
/this-path-should-not-exist-12345
    ↓
404 Not Found
```

The request still successfully passed through:

```text
DNS resolution
      ↓
Network connection
      ↓
TLS handshake
      ↓
HTTP request
      ↓
HTTP response
```

Therefore, the `404` response demonstrates that the server or intermediary was reachable and processed the HTTP request.

### 3.8 What a 404 Does Not Mean

A `404 Not Found` response does not automatically mean:

```text
DNS failure
Server unreachable
TLS failure
Application completely unavailable
```

It specifically describes the result associated with the requested resource.

This distinction is important when analyzing web applications.

### 3.9 Security Researcher Mental Model

A status code is an observation, not automatically a security finding.

For example:

```http
HTTP/1.1 200 OK
```

should not immediately be interpreted as:

```text
"The endpoint is vulnerable."
```

Instead, ask:

1. What request produced the response?
2. Which HTTP method was used?
3. What resource was requested?
4. Was authentication involved?
5. Which identity was being used?
6. Which request headers were relevant?
7. Was an intermediary involved?
8. What data was actually returned?
9. Is the behavior within the authorized testing scope?

The same principle applies to other status codes.

A response must be interpreted in relation to the request, application behavior, authorization context, and testing scope.

### 3.10 Response Direction

The complete HTTP exchange can be represented as:

```text
CLIENT
   │
   │ HTTP Request
   ▼
SERVER / INTERMEDIARY
   │
   │ HTTP Response
   ▼
CLIENT
```

In curl verbose output:

```text
>
```

represents client-to-server request data.

```text
<
```

represents server-to-client response data.

This provides a useful visual distinction when reading verbose HTTP output.

### 3.11 Connection Sequence

The observed exchange can be summarized as:

```text
DNS resolution
      ↓
IPv4 connection
      ↓
TCP connection to port 443
      ↓
TLS 1.3 handshake
      ↓
HTTP/1.1 negotiation
      ↓
HTTP request
      ↓
HTTP response
      ↓
Response body
```

The HTTP response occurs only after the underlying network and TLS connection has been established.

### 3.12 Part 3 Verification

The successful resource request produced:

```text
HTTP/1.1 200 OK
```

The deliberately nonexistent resource produced:

```text
HTTP/1.1 404 Not Found
```

Both requests successfully completed DNS resolution, network connection, TLS negotiation, and HTTP processing.

This demonstrates that HTTP status codes describe the outcome associated with a particular HTTP request rather than the overall state of network connectivity.

### 3.13 Key Takeaway

An HTTP response consists of a status line, response headers, a blank line, and an optional response body.

The status line identifies the HTTP version and response status.

Response headers provide metadata and behavioral information.

The response body contains the returned representation when one is provided.

Most importantly:

```text
HTTP status
     ≠
automatic security conclusion
```

A security researcher must interpret the response together with the request, authentication state, authorization context, application behavior, evidence, and scope.
## Part 4 — HTTP Methods

HTTP methods communicate the intended operation for a request.

Common methods include:

```text
GET
POST
PUT
PATCH
DELETE
HEAD
OPTIONS
```

The method is one component of an HTTP request and appears in the request line.

A simplified request is:

```http
GET / HTTP/1.1
Host: example.com
```

The first token is the HTTP method.

### 4.1 Method Mental Model

An HTTP method communicates the intended operation, but the method name does not guarantee what the server will actually permit.

A useful model is:

```text
HTTP Method
     ↓
Intended Operation
     ↓
Server Implementation
     ↓
Authorization + Application Logic
     ↓
Actual Behavior
```

Therefore, a security researcher should observe the server's actual behavior rather than assuming behavior from the method name alone.

For example, seeing `DELETE` in an application does not by itself prove that deletion is possible or authorized.

### 4.2 GET

`GET` is used to request a representation of a resource.

The controlled observation was performed with:

```bash
curl -sS -o /dev/null -w 'Method: GET\nHTTP version: %{http_version}\nStatus: %{http_code}\nContent type: %{content_type}\n' https://example.com/
```

The observed result was:

```text
Method: GET
HTTP version: 2
Status: 200
Content type: text/html
```

This demonstrates that the request used HTTP/2 and that the server returned a successful response with an HTML content type.

The `-o /dev/null` option discarded the response body.

### 4.3 HEAD

The second controlled observation used:

```bash
curl -sS -I https://example.com/
```

The `-I` option causes curl to make a HEAD request.

The observed response was:

```http
HTTP/2 200
date: Fri, 18 Sep 2026 15:56:41 GMT
content-type: text/html
server: cloudflare
last-modified: Tue, 15 Sep 2026 23:38:37 GMT
allow: GET, HEAD
accept-ranges: bytes
age: 2868
cf-cache-status: HIT
cf-ray: a3d18ac7ce5f449e-MRS
```

The response contains metadata such as:

```http
content-type: text/html
```

but curl does not retrieve the normal response body for the HEAD request.

### 4.4 GET Versus HEAD

The two requests targeted the same resource:

```text
https://example.com/
```

The observed behavior can be summarized as:

| Method | Purpose                                                    | Observed status | Body retrieved                                                              |
| ------ | ---------------------------------------------------------- | --------------: | --------------------------------------------------------------------------- |
| GET    | Request the resource representation                        |             200 | Yes in normal GET behavior; discarded by `-o /dev/null` in this observation |
| HEAD   | Request response metadata without the normal response body |             200 | No                                                                          |

The important distinction is that HEAD is useful when inspecting response metadata without retrieving the resource representation.

### 4.5 Method Does Not Equal Security Impact

It is incorrect to assume that a method automatically determines whether an operation is safe, dangerous, authorized, or vulnerable.

For example:

```text
GET
```

does not automatically mean:

```text
No security impact
```

Likewise:

```text
POST
```

does not automatically mean:

```text
Dangerous
```

The actual security properties depend on the application's implementation, authorization controls, state changes, input handling, and other factors.

A better model is:

```text
Method
  +
Endpoint
  +
Authentication State
  +
Authorization
  +
Application Logic
  +
Input
  =
Observed Behavior
```

### 4.6 Method Support Is Application-Specific

Not every server or endpoint necessarily supports every HTTP method.

A method may be:

```text
supported
unsupported
restricted
redirected
handled by an intermediary
handled differently by the application
```

Therefore, a researcher should observe the actual response rather than infer behavior solely from documentation or convention.

### 4.7 Security Researcher Mental Model

When examining an HTTP request, identify:

1. The HTTP method.
2. The request target.
3. The HTTP version.
4. The relevant request headers.
5. Whether a request body is present.
6. The authentication context.
7. The authorization context.
8. The resulting server behavior.
9. Whether the behavior is within authorized scope.

The method is therefore an important clue, but it is only one part of the complete request.

### 4.8 Part 4 Verification

The controlled GET request produced:

```text
Method: GET
HTTP version: 2
Status: 200
Content type: text/html
```

The controlled HEAD request produced:

```text
HTTP/2 200
content-type: text/html
allow: GET, HEAD
```

The observations demonstrate that the same resource can respond to different HTTP methods while the resulting message characteristics differ according to the method's purpose.

### 4.9 Key Takeaway

HTTP methods communicate intended operations.

`GET` requests a resource representation.

`HEAD` requests response metadata without the normal response body.

Other methods such as `POST`, `PUT`, `PATCH`, `DELETE`, and `OPTIONS` have different defined semantics, but the actual behavior of an application must always be verified.

Most importantly:

```text
HTTP Method
     ≠
Automatic Security Conclusion
```

A security researcher studies the method together with the endpoint, authentication state, authorization controls, application logic, inputs, response, and scope.
## Part 5 — HTTP Headers

HTTP headers are metadata fields carried with HTTP requests and responses.

They provide additional information about the message being exchanged without being part of the main resource representation.

A simplified model is:

```text
HTTP Message
│
├── Start Line
│
├── Headers
│
├── Blank Line
│
└── Optional Body
```

For a request:

```text
Client
   │
   │ Request headers
   ▼
Server
```

For a response:

```text
Server
   │
   │ Response headers
   ▼
Client
```

The direction matters.

Request headers are sent by the client.

Response headers are sent by the server or an intermediary.

### 5.1 Response Headers

A controlled observation was performed with:

```bash
curl -sS -D - -o /dev/null https://example.com/
```

The observed response headers were:

```http
HTTP/2 200
date: Fri, 18 Sep 2026 16:16:56 GMT
content-type: text/html
server: cloudflare
last-modified: Tue, 15 Sep 2026 23:38:37 GMT
allow: GET, HEAD
accept-ranges: bytes
age: 4082
cf-cache-status: HIT
cf-ray: a3d1a86edc91e1d0-MRS
```

The command uses:

```text
-D -
```

to print the response headers to standard output.

The:

```text
-o /dev/null
```

option discards the response body.

This allows the observation to focus on the response metadata.

Several different types of information are visible.

For example:

```http
Content-Type: text/html
```

identifies the media type associated with the response.

```http
Allow: GET, HEAD
```

advertises methods associated with the resource.

```http
Server: cloudflare
```

is a server or intermediary identification value.

The remaining headers provide additional information about caching, resource modification, range support, and request processing.

A header should be treated first as an observed piece of metadata.

Its presence does not automatically establish a security vulnerability.

For example, observing:

```http
Server: cloudflare
```

does not by itself prove the location or identity of the origin server.

Likewise, observing:

```http
Allow: GET, HEAD
```

does not by itself prove that these methods are unrestricted or that other methods cannot be processed elsewhere.

The correct approach is:

```text
Observe
   ↓
Interpret
   ↓
Verify
   ↓
Assess security relevance
```

### 5.2 Request Headers

Request headers travel from the client toward the server or intermediary.

A controlled observation was performed with:

```bash
curl -sv -o /dev/null -H 'X-Lab-Observation: headers' https://example.com/ 2>&1 | sed -n '/> GET/,/^$/p'
```

The request portion of the verbose output showed:

```http
> GET / HTTP/2
> Host: example.com
> User-Agent: curl/8.21.0
> Accept: */*
> X-Lab-Observation: headers
```

The `>` marker used by verbose curl indicates client-to-server communication.

The request therefore contained several headers:

```http
Host: example.com
User-Agent: curl/8.21.0
Accept: */*
X-Lab-Observation: headers
```

The custom header:

```http
X-Lab-Observation: headers
```

was deliberately added with the `-H` option.

This demonstrates that a client can send additional request metadata to the server.

However, a client-supplied header should not automatically be considered trusted.

The server or application determines whether and how that value is used.

The security mental model is:

```text
Client-supplied header
        ↓
Server receives header
        ↓
Application processes header
        ↓
Observed behavior
```

The presence of a header is therefore an observation.

Whether the application trusts, ignores, transforms, validates, or otherwise processes that header is a separate question.

### 5.3 Request Headers Versus Response Headers

The observations demonstrate the directional difference between the two categories.

```text
Request headers

Client
  │
  │ Host
  │ User-Agent
  │ Accept
  │ X-Lab-Observation
  ▼
Server / intermediary
```

and:

```text
Response headers

Server / intermediary
  │
  │ Content-Type
  │ Server
  │ Allow
  │ Cache metadata
  ▼
Client
```

A useful researcher mental model is:

```text
Request headers
= information supplied with the request

Response headers
= information supplied with the response
```

This distinction becomes important when analyzing authentication, sessions, caching, content handling, cross-origin behavior, and other web security mechanisms.

### 5.4 Controlled Observation Verification

A second observation was performed with:

```bash
curl -sS -D - -o /dev/null -H 'X-Lab-Observation: headers' https://example.com/
```

The response again returned:

```http
HTTP/2 200
date: Fri, 18 Sep 2026 16:18:49 GMT
content-type: text/html
server: cloudflare
last-modified: Tue, 15 Sep 2026 23:38:37 GMT
allow: GET, HEAD
accept-ranges: bytes
age: 4196
cf-cache-status: HIT
cf-ray: a3d1ab353ced2e37-MRS
```

The response metadata was consistent with the earlier observation.

Some values changed between requests, including:

```text
date
age
cf-ray
```

This is expected because individual HTTP transactions can produce different request identifiers and time-dependent metadata.

The important observation is that the response continued to contain HTTP response headers describing the returned resource and processing context.

### 5.5 Key Takeaway

HTTP headers provide metadata associated with HTTP messages.

Request headers travel from the client toward the server.

Response headers travel from the server or intermediary toward the client.

Headers can provide useful information about:

```text
Request context
Response representation
Caching
Content handling
Server/intermediary behavior
Resource metadata
```

Most importantly:

```text
Header observed
      ≠
Automatic security conclusion
```

A security researcher first records what the header says, then determines what the application actually does with that information.
## Part 6 — HTTP Status Codes

HTTP status codes communicate the result of processing an HTTP request.

They are included in the response status line and are grouped into five classes:

```text
1xx → Informational
2xx → Success
3xx → Redirection
4xx → Client-side / request-related error
5xx → Server-side error
```

A status code describes the outcome of a particular HTTP request. It should not automatically be interpreted as a security finding.

---

### 6.1 Why Status Codes Matter

A web application receives requests and produces responses.

The status code provides an initial description of how the server or an intermediary handled that request.

A simplified exchange is:

```text
Client
   │
   │ HTTP Request
   ▼
Server / Intermediary
   │
   │ HTTP Response
   │
   ├── Status Code
   ├── Headers
   └── Optional Body
   ▼
Client
```

For example:

```http
HTTP/2 200
Content-Type: text/html
```

The `200` indicates that the request was successfully processed.

A different request might produce:

```http
HTTP/2 404
Content-Type: text/html
```

The `404` indicates that the requested resource was not found.

The status code therefore belongs to the **response**, not the request.

---

### 6.2 Controlled Observation: HTTP 200

The following command was used to observe the status code returned for the root resource of `example.com`:

```bash
curl -sS -o /dev/null -w 'Status: %{http_code}\nHTTP version: %{http_version}\nURL: %{url_effective}\n' https://example.com/
```

Observed result:

```text
Status: 200
HTTP version: 2
URL: https://example.com/
```

This demonstrates a successful HTTP response.

The important observations are:

* `Status: 200` — the HTTP response status was `200`.
* `HTTP version: 2` — the exchange used HTTP/2.
* The effective URL was `https://example.com/`.
* The response was successfully received by the client.

A `200` status does not by itself mean that an application is secure. It only describes the result of this particular request.

---

### 6.3 Controlled Observation: HTTP 404

A second request used a deliberately nonexistent path:

```bash
curl -sS -o /dev/null -w 'Status: %{http_code}\nHTTP version: %{http_version}\nURL: %{url_effective}\n' https://example.com/this-path-should-not-exist-12345
```

Observed result:

```text
Status: 404
HTTP version: 2
URL: https://example.com/this-path-should-not-exist-12345
```

The response status was `404`.

`404 Not Found` indicates that the requested resource was not found.

This is an important networking observation because the request successfully progressed far enough to receive an HTTP response.

The observation can be represented as:

```text
DNS
 │
 ▼
Network connection
 │
 ▼
TLS / HTTPS
 │
 ▼
HTTP request
 │
 ▼
HTTP response
 │
 └── 404 Not Found
```

Therefore:

```text
404 ≠ DNS failure
404 ≠ connection failure
404 ≠ TLS failure
404 ≠ HTTP protocol failure
```

Instead, the client received a valid HTTP response describing the result of the requested resource lookup.

---

### 6.4 Status Code Classes

HTTP status codes are divided into five classes.

#### 1xx — Informational

`1xx` responses provide intermediate information about the request.

Examples include:

```text
100 Continue
101 Switching Protocols
```

These responses are less commonly encountered during ordinary browser-based web testing.

The important concept is that `1xx` represents an informational response rather than a final success or error classification.

---

#### 2xx — Successful

`2xx` responses indicate successful processing of a request.

Common examples include:

```text
200 OK
201 Created
202 Accepted
204 No Content
```

`200 OK` is commonly encountered when retrieving a resource successfully.

For example, the controlled observation above produced:

```text
Status: 200
```

A `2xx` response should be interpreted in the context of the request that produced it.

For security testing:

```text
200 ≠ automatically vulnerable
```

A successful response may simply indicate that the requested resource was available.

---

#### 3xx — Redirection

`3xx` responses indicate that additional action may be required to complete or continue the request.

Common examples include:

```text
301 Moved Permanently
302 Found
303 See Other
304 Not Modified
307 Temporary Redirect
308 Permanent Redirect
```

Redirect responses are particularly important when studying:

* authentication flows
* login redirects
* URL handling
* navigation
* proxy behavior
* cache behavior

The `304 Not Modified` response observed earlier during browser testing is another example of a `3xx` response.

It indicated that the browser's cached representation could still be used rather than transferring the full resource again.

---

#### 4xx — Client-Side / Request-Related Errors

`4xx` responses indicate that the request could not be fulfilled as made.

Common examples include:

```text
400 Bad Request
401 Unauthorized
403 Forbidden
404 Not Found
405 Method Not Allowed
```

The controlled nonexistent-path request produced:

```text
404 Not Found
```

Different `4xx` status codes communicate different conditions.

For example:

```text
401 → authentication is required or has not been satisfied
403 → request is understood but access is refused
404 → requested resource was not found
405 → HTTP method is not allowed for the resource
```

These meanings are useful during security testing, but the status code alone is not sufficient to establish a vulnerability.

---

#### 5xx — Server-Side Errors

`5xx` responses indicate that the server encountered a condition preventing it from successfully fulfilling the request.

Common examples include:

```text
500 Internal Server Error
502 Bad Gateway
503 Service Unavailable
504 Gateway Timeout
```

The distinction between `4xx` and `5xx` is useful:

```text
4xx
│
└── Problem associated with the request or its handling

5xx
│
└── Server-side failure while processing the request
```

However, real-world architectures can involve multiple components such as:

```text
Browser
   │
   ▼
CDN
   │
   ▼
Reverse Proxy
   │
   ▼
Load Balancer
   │
   ▼
Application
   │
   ▼
Database
```

Consequently, a `5xx` response does not automatically identify which component experienced the problem.

---

### 6.5 Security Researcher Mental Model

A status code should be treated as an observation that requires context.

For example:

```text
Observation:
GET /admin → 403
```

This tells us that the request received a `403` response.

It does not automatically prove:

```text
"admin is securely protected"
```

Likewise:

```text
Observation:
GET /admin → 200
```

does not automatically prove:

```text
"admin is vulnerable"
```

The researcher must consider:

```text
Request
   ↓
Status code
   ↓
Response body
   ↓
Headers
   ↓
Authentication state
   ↓
Authorization state
   ↓
Application behavior
   ↓
Security conclusion
```

This distinction is fundamental to responsible web security testing.

---

### 6.6 Key Takeaway

HTTP status codes provide structured information about the result of an HTTP request.

The five major classes are:

```text
1xx → Informational
2xx → Successful
3xx → Redirection
4xx → Client / request-related error
5xx → Server-side error
```

The controlled observations demonstrated:

```text
GET /
→ 200 OK

GET /this-path-should-not-exist-12345
→ 404 Not Found
```

Both requests successfully produced HTTP responses.

The key lesson is:

> A status code is evidence about HTTP behavior, not a security verdict.

A bug-bounty researcher should combine status codes with the request, response headers, response body, authentication state, authorization context, and application behavior before drawing conclusions.
## Part 7 — Status Codes and Headers Together

HTTP responses should be interpreted as a collection of related fields rather than by looking at the status code alone.

A simplified HTTP response contains:

```text
HTTP Response
│
├── Status
│
├── Headers
│
└── Optional Body
```

The status describes the response outcome, while headers provide additional metadata about how the response should be interpreted or handled.

---

### 7.1 Controlled Observation: 200 Response

The following command was used to inspect the response headers for the root resource:

```bash
curl -sS -D - -o /dev/null https://example.com/
```

Observed response:

```http
HTTP/2 200
date: Fri, 18 Sep 2026 16:34:56 GMT
content-type: text/html
server: cloudflare
last-modified: Tue, 15 Sep 2026 23:38:37 GMT
allow: GET, HEAD
accept-ranges: bytes
age: 5162
cf-cache-status: HIT
cf-ray: a3d1c2cc5956fa41-MRS
```

Important observations:

* The response used HTTP/2.
* The status was `200`.
* The response content type was `text/html`.
* The response included a `server` header identifying Cloudflare.
* `Allow` indicated `GET, HEAD` for this observed response.
* `Accept-Ranges: bytes` indicated support for byte-range requests.
* `CF-Cache-Status: HIT` indicated a cache hit at the observed Cloudflare layer.
* `Age: 5162` indicated that the cached response had an age value of 5162 seconds at the time of observation.

These fields provide more information than the `200` status alone.

---

### 7.2 Controlled Observation: 404 Response

The same header observation was performed against a deliberately nonexistent path:

```bash
curl -sS -D - -o /dev/null https://example.com/this-path-should-not-exist-12345
```

Observed response:

```http
HTTP/2 404
date: Fri, 18 Sep 2026 16:35:05 GMT
content-type: text/html
server: cloudflare
age: 6572
cf-cache-status: HIT
cf-ray: a3d1c3049f84764d-MRS
```

Important observations:

* The response also used HTTP/2.
* The status was `404`.
* The response content type was still `text/html`.
* The observed `server` header was still `cloudflare`.
* `CF-Cache-Status: HIT` was also present.
* `Age` had a value of `6572`.
* The `Allow` header observed in the `200` response was not present in this response.
* `Accept-Ranges` was not present in this response.

The response therefore contained several similarities to the `200` response while still representing a different HTTP outcome.

---

### 7.3 Comparing the Responses

The two observations can be compared as follows:

```text
GET /
│
├── HTTP/2
├── 200
├── Content-Type: text/html
├── Server: cloudflare
├── Allow: GET, HEAD
├── Accept-Ranges: bytes
└── CF-Cache-Status: HIT


GET /this-path-should-not-exist-12345
│
├── HTTP/2
├── 404
├── Content-Type: text/html
├── Server: cloudflare
└── CF-Cache-Status: HIT
```

This comparison demonstrates that a response is not defined by its status code alone.

The status code provides the primary classification:

```text
200 → successful response
404 → requested resource not found
```

The headers provide additional metadata.

Therefore, a useful researcher habit is:

```text
Status
  +
Headers
  +
Body
  =
Response behavior
```

---

### 7.4 Presence and Absence of Headers

When comparing responses, both the presence and absence of headers can be observed.

For example:

```text
200 response
→ Allow: GET, HEAD
→ Accept-Ranges: bytes

404 response
→ Allow: not observed
→ Accept-Ranges: not observed
```

However, the absence of a header in one response should not immediately be interpreted as a vulnerability or security control.

A header may be:

* response-specific
* generated by a particular application component
* added by an intermediary
* omitted because it is not relevant to that response
* affected by caching or routing behavior

Therefore:

```text
Header absent
    ≠
Security weakness
```

Additional controlled observations are required before drawing a security conclusion.

---

### 7.5 Intermediaries and Response Interpretation

The observed responses included:

```http
server: cloudflare
cf-cache-status: HIT
cf-ray: ...
```

These headers provide evidence that Cloudflare was involved in the observed HTTP exchange.

This is important because modern web applications frequently contain multiple layers:

```text
Client
   │
   ▼
CDN / Edge
   │
   ▼
Reverse Proxy
   │
   ▼
Application
   │
   ▼
Backend Services
```

The component that returns a response to the client is not necessarily the application's origin server.

For example, a cached `404` may be served by an intermediary without requiring the request to reach the application origin.

Therefore, observed response headers should be treated as evidence about the observed path, not as automatic proof of the complete backend architecture.

---

### 7.6 Security Researcher Mental Model

A security researcher should avoid reducing an observation to:

```text
200 = good
404 = bad
```

or:

```text
403 = secure
200 = vulnerable
```

Instead, the response should be analyzed in context:

```text
Request
   │
   ├── Method
   ├── URL
   ├── Headers
   └── Body
   │
   ▼
HTTP Response
   │
   ├── Status
   ├── Headers
   └── Body
   │
   ▼
Application behavior
   │
   ▼
Security hypothesis
   │
   ▼
Controlled validation
```

The status code helps identify what happened. Headers and body content help explain the response. Application behavior determines whether a security-relevant condition may actually exist.

---

### 7.7 Key Takeaway

HTTP status codes and headers should be interpreted together.

The controlled observations showed:

```text
GET /
→ 200
→ several response headers
→ cached response observed

GET /this-path-should-not-exist-12345
→ 404
→ several response headers
→ cached response observed
```

The two responses shared several characteristics while differing in status and some headers.

The key lesson is:

> **A status code is one piece of response evidence; headers and body provide additional context needed to understand HTTP behavior.**

For bug-bounty work, careful comparison of complete responses is more useful than treating individual status codes or headers as automatic security findings.
## Part 8 — HTTP Caching and Conditional Requests

HTTP caching allows previously retrieved representations of resources to be reused instead of transferring the complete representation for every request.

Caching can occur in different components, including:

```text
Browser
   │
   ▼
CDN / Cache
   │
   ▼
Reverse Proxy
   │
   ▼
Application / Origin
```

HTTP provides mechanisms that allow clients and intermediaries to determine whether a cached representation can still be reused.

Two important mechanisms are:

```text
Last-Modified
ETag
```

Clients can use conditional request headers to ask whether the cached representation is still current.

---

### 8.1 Why HTTP Caching Exists

Without caching, a client may need to retrieve the complete representation of a resource every time it requests it.

A simplified exchange is:

```text
Client
   │
   │ GET /resource
   ▼
Server
   │
   │ 200 + complete representation
   ▼
Client
```

With caching, the client may already have a representation stored locally.

Instead of requesting the complete representation again, the client can make a conditional request:

```text
Client
   │
   │ Conditional GET
   │
   │ "Has this representation changed?"
   ▼
Server / Cache
   │
   ├── Changed
   │      ↓
   │    200 + new representation
   │
   └── Not changed
          ↓
        304 Not Modified
```

A `304 Not Modified` response allows the client to reuse its existing cached representation.

---

### 8.2 Last-Modified

`Last-Modified` provides a timestamp associated with the modification time of a resource representation.

An observed response contained:

```http
Last-Modified: Tue, 15 Sep 2026 23:38:37 GMT
```

This gives the client information that can be used for subsequent conditional requests.

The important relationship is:

```text
Response
   │
   └── Last-Modified
          │
          ▼
Client stores representation
          │
          ▼
Later request
          │
          └── If-Modified-Since
```

`Last-Modified` is response metadata.

`If-Modified-Since` is a request header used by the client for conditional validation.

---

### 8.3 ETag

An `ETag` is another mechanism for identifying a particular representation of a resource.

The observed `304` response included:

```http
ETag: "6aa9d6fd-22f"
```

An ETag can be used in conditional requests through the `If-None-Match` request header.

The conceptual relationship is:

```text
Response
   │
   └── ETag
          │
          ▼
Client stores representation
          │
          ▼
Later request
          │
          └── If-None-Match
```

Unlike a modification timestamp, an ETag is an identifier for a particular representation.

The exact generation method of an ETag depends on the server or application.

A researcher should therefore observe the value and behavior rather than assume how it was generated.

---

### 8.4 Controlled Observation: Cached Response

The following command was used to inspect cache-related response headers:

```bash
curl -sS -D - -o /dev/null https://example.com/ | grep -iE '^(HTTP/|cache-control:|etag:|last-modified:|age:|cf-cache-status:)'
```

Observed result:

```text
HTTP/2 200
last-modified: Tue, 15 Sep 2026 23:38:37 GMT
age: 5341
cf-cache-status: HIT
```

Important observations:

* The response used HTTP/2.
* The status was `200`.
* `Last-Modified` was present.
* `Age` was present.
* `CF-Cache-Status: HIT` was present.
* No `Cache-Control` header was returned by this particular filtered observation.
* No `ETag` header appeared in this particular `200` response.

The observation demonstrates that caching-related metadata can appear in responses even when not every possible caching header is present.

---

### 8.5 Controlled Observation: If-Modified-Since

The observed `Last-Modified` timestamp was then supplied in an `If-Modified-Since` request header:

```bash
curl -sS -D - -o /dev/null \
  -H 'If-Modified-Since: Tue, 15 Sep 2026 23:38:37 GMT' \
  https://example.com/
```

Observed response:

```http
HTTP/2 304
date: Fri, 18 Sep 2026 16:38:09 GMT
allow: GET, HEAD
age: 5356
server: cloudflare
last-modified: Tue, 15 Sep 2026 23:38:37 GMT
etag: "6aa9d6fd-22f"
cf-cache-status: HIT
cf-ray: a3d1c7854dc4e18b-MRS
```

The status changed from the earlier `200` response to:

```text
304 Not Modified
```

This is a direct observation of conditional request behavior.

The client effectively supplied:

```http
If-Modified-Since: Tue, 15 Sep 2026 23:38:37 GMT
```

The observed response indicated that the representation had not been modified relative to that condition.

---

### 8.6 200 Versus 304

The two observations can be represented as:

```text
Initial request

GET /
   │
   ▼
200 OK
   │
   ├── representation available
   ├── Last-Modified
   └── cache metadata
```

Conditional request:

```text
GET /
If-Modified-Since: Tue, 15 Sep 2026 23:38:37 GMT
   │
   ▼
304 Not Modified
   │
   ├── Last-Modified
   ├── ETag
   └── cache metadata
```

The important distinction is:

```text
200
→ representation is returned

304
→ representation has not changed according to the conditional validation
→ client can reuse its cached representation
```

A `304` response normally does not contain the complete resource representation because the client is expected to use its existing cached copy.

---

### 8.7 Cache Freshness Versus Cache Validation

Caching involves two related but different ideas.

#### Freshness

A cached representation may be considered fresh according to the applicable caching rules.

If it is fresh, the client or intermediary may be able to reuse it without contacting the origin.

#### Validation

A client or cache can ask whether its stored representation is still current.

Conditional requests provide a mechanism for this validation.

The simplified model is:

```text
Cached representation
        │
        ▼
Is it fresh?
   │
   ├── Yes
   │     ↓
   │   Reuse cache
   │
   └── No / needs validation
          │
          ▼
      Conditional request
          │
          ├── Unchanged
          │      ↓
          │    304
          │
          └── Changed
                 ↓
               200 + new representation
```

The exact caching decision depends on HTTP caching rules and the headers supplied by the relevant components.

---

### 8.8 Age and Cache Status

The observed responses included:

```http
Age: 5341
CF-Cache-Status: HIT
```

and later:

```http
Age: 5356
CF-Cache-Status: HIT
```

`Age` provides an indication of how long a response has been stored in a shared cache.

`CF-Cache-Status: HIT` indicates that the observed Cloudflare layer served the response from cache.

These headers are useful observations when studying intermediary behavior.

However:

```text
Cache header observed
        ≠
Security vulnerability
```

The presence of caching does not automatically indicate incorrect caching, information disclosure, or authorization failure.

A security conclusion requires evidence about what was cached, for whom it was available, and under what conditions.

---

### 8.9 Intermediary Caching

Modern web applications frequently use intermediary infrastructure.

For example:

```text
Client
   │
   ▼
CDN
   │
   ▼
Reverse Proxy
   │
   ▼
Application
   │
   ▼
Backend
```

A cached response may therefore be served without reaching the application for every request.

The observed:

```http
server: cloudflare
cf-cache-status: HIT
```

provides evidence that Cloudflare was involved in the observed exchange.

However, these observations do not establish the complete architecture of the application.

They only describe what was visible from the client side during the controlled test.

---

### 8.10 Security Researcher Mental Model

Caching becomes security-relevant when cache behavior interacts incorrectly with application state or access controls.

A researcher should therefore ask questions such as:

```text
What resource is being cached?

Who can receive the cached representation?

Does the representation contain user-specific data?

Does authentication affect the response?

Does authorization affect the response?

Are cache keys correctly separated?

Are sensitive responses explicitly controlled?

Does a cached response remain available when the user's state changes?
```

These questions should only be investigated within authorized scope and using non-destructive testing.

The key distinction is:

```text
Caching mechanism
      ↓
Observed behavior
      ↓
Security hypothesis
      ↓
Controlled validation
      ↓
Evidence
```

A researcher should not report a cache header simply because it exists.

---

### 8.11 Important Distinction: 304 Is Not an Error

`304 Not Modified` belongs to the `3xx` status-code class.

Despite the name, it is not an indication that something went wrong.

It is a normal part of conditional request processing.

The observed exchange demonstrates this:

```text
Stored representation
       │
       ▼
If-Modified-Since
       │
       ▼
304 Not Modified
       │
       ▼
Reuse cached representation
```

Therefore:

```text
304 ≠ failure
304 ≠ vulnerability
304 ≠ server error
```

It is a valid HTTP response used during cache validation.

---

### 8.12 Key Takeaway

HTTP caching allows clients and intermediaries to reuse previously retrieved representations.

The controlled observations demonstrated:

```text
Initial response
→ 200
→ Last-Modified
→ Age
→ CF-Cache-Status: HIT

Conditional request
→ If-Modified-Since
→ 304
→ Last-Modified
→ ETag
→ Age
→ CF-Cache-Status: HIT
```

The important relationships are:

```text
Last-Modified
       ↕
If-Modified-Since

ETag
       ↕
If-None-Match
```

The key lesson is:

> **Conditional requests allow a client or cache to determine whether an existing representation can be reused without transferring the complete resource again.**

For security research, caching headers and `304` responses are observations that require application and authorization context before any security conclusion can be made.
## Part 9 — Request and Response Bodies

HTTP messages can contain a body that carries a representation or application data.

The body is separate from the HTTP status line and headers.

A simplified message structure is:

```text
HTTP Message
│
├── Start Line
│
├── Headers
│
├── Blank Line
│
└── Optional Body
```

The body is optional. Some HTTP messages have no body, while others use the body to transport HTML, JSON, plain text, form data, files, or other representations.

---

### 9.1 Response Bodies

A response body contains the representation or data returned to the client.

For example, requesting the root resource from `example.com` returned:

```text
HTTP/2 200
content-type: text/html
...

<!doctype html>
<html lang="en">
...
```

The important relationship is:

```text
HTTP Response
│
├── Status
│   └── 200
│
├── Headers
│   └── Content-Type: text/html
│
├── Blank Line
│
└── Body
    └── HTML document
```

The `Content-Type` header describes the representation carried in the response body.

In this observation, the body contained HTML and the `Content-Type` indicated `text/html`.

A browser can interpret that HTML and render it as a web page.

---

### 9.2 Request Bodies

A request can also contain a body.

Request bodies are commonly used when the client needs to send data to the server.

For example, a `POST` request can contain application data:

```text
POST / HTTP/1.1
Host: 127.0.0.1:8001
Content-Type: text/plain
Content-Length: 28

hello from the HTTP body lab
```

The structure is:

```text
HTTP Request
│
├── Request Line
│   └── POST / HTTP/1.1
│
├── Headers
│   ├── Content-Type
│   └── Content-Length
│
├── Blank Line
│
└── Body
    └── hello from the HTTP body lab
```

The blank line separates the headers from the body.

This separation is important when analyzing HTTP traffic because the request metadata and the transmitted application data are different parts of the message.

---

### 9.3 Content-Type and Body Representation

The `Content-Type` header identifies the media type of the body.

Examples include:

```text
Content-Type: text/plain
```

```text
Content-Type: text/html
```

```text
Content-Type: application/json
```

The header does not itself contain the application data. Instead, it describes how the body should be interpreted.

For example:

```text
Content-Type: text/plain

hello from the HTTP body lab
```

and:

```text
Content-Type: application/json

{"crop":"maize","growth_stage":"vegetative"}
```

both contain bodies, but the representations are different.

The HTTP layer transports the body. The receiving application can then interpret the body according to the declared or expected format.

---

### 9.4 Controlled Observation: Plain-Text Request Body

A local HTTP server was used to observe a request body without interacting with an external application.

The request was generated with:

```bash
curl -sS -X POST \
  -H 'Content-Type: text/plain' \
  --data 'hello from the HTTP body lab' \
  http://127.0.0.1:8001/
```

The local server reported:

```text
===== REQUEST RECEIVED =====
Method: POST
Content-Type: text/plain
Content-Length: 28
Body: hello from the HTTP body lab
```

The server then logged:

```text
"POST / HTTP/1.1" 200 -
```

This demonstrates that the request body was transmitted separately from the request headers.

The observed structure can be represented as:

```text
POST / HTTP/1.1
Content-Type: text/plain
Content-Length: 28

hello from the HTTP body lab
```

The server read the declared body length and received the expected text.

---

### 9.5 Controlled Observation: JSON Request Body

The same local server was then used to observe a JSON body:

```bash
curl -sS -X POST \
  -H 'Content-Type: application/json' \
  --data '{"crop":"maize","growth_stage":"vegetative"}' \
  http://127.0.0.1:8001/
```

The server reported:

```text
===== REQUEST RECEIVED =====
Method: POST
Content-Type: application/json
Content-Length: 44
Body: {"crop":"maize","growth_stage":"vegetative"}
```

The server then logged:

```text
"POST / HTTP/1.1" 200 -
```

This demonstrates that JSON is not a special HTTP transport mechanism.

It is application data carried inside the HTTP request body.

The HTTP message can therefore be viewed as:

```text
POST / HTTP/1.1
Content-Type: application/json
Content-Length: 44

{"crop":"maize","growth_stage":"vegetative"}
```

The `Content-Type` identifies the body as JSON, while the body itself contains the JSON data.

---

### 9.6 Request Body Versus Response Body

Request and response bodies travel in opposite directions.

```text
CLIENT                              SERVER
  │                                    │
  │  HTTP Request                      │
  │  ├── Headers                       │
  │  └── Request Body                  │
  │ ─────────────────────────────────> │
  │                                    │
  │  HTTP Response                     │
  │  ├── Headers                       │
  │  └── Response Body                 │
  │ <───────────────────────────────── │
  │                                    │
```

A request body contains data sent by the client to the server.

A response body contains data returned by the server to the client.

For example:

```text
Request Body
└── {"crop":"maize","growth_stage":"vegetative"}

Response Body
└── Request body received
```

These are two separate bodies belonging to two different HTTP messages.

This distinction becomes particularly important when analyzing APIs, forms, authentication flows, and application behavior.

---

### 9.7 Content-Length

`Content-Length` indicates the length of the message body in bytes when that framing mechanism is used.

The controlled plain-text observation reported:

```text
Content-Length: 28
```

for:

```text
hello from the HTTP body lab
```

The JSON observation reported:

```text
Content-Length: 44
```

for:

```json
{"crop":"maize","growth_stage":"vegetative"}
```

`Content-Length` belongs to the HTTP message framing layer.

It does not describe the number of JSON fields, application objects, or other semantic elements contained in the body.

The receiving HTTP implementation can use the body length to determine how much data belongs to the message body.

When analyzing traffic, researchers should distinguish:

```text
HTTP message properties
        │
        ├── Content-Length
        └── Content-Type
                │
                ▼
        Application representation
                │
                └── JSON / HTML / text / etc.
```

---

### 9.8 Security Researcher Mental Model

A security researcher should treat the HTTP body as an important part of the application's input and output surface.

A request should be understood as:

```text
Request
│
├── Method
├── Target
├── Headers
├── Cookies
└── Body
```

A response should be understood as:

```text
Response
│
├── Status
├── Headers
└── Body
```

When examining an application, the body may contain:

* Form data
* JSON objects
* Search parameters
* User-provided text
* Identifiers
* File metadata
* Other application-specific data

However, the presence of data in a body does not automatically indicate a vulnerability.

The correct workflow is:

```text
Observe
   ↓
Identify the representation
   ↓
Understand how the application uses it
   ↓
Form a testable hypothesis
   ↓
Perform an authorized controlled test
   ↓
Validate the behavior
   ↓
Assess impact
```

The important lesson is that HTTP transports data; the application's behavior determines what that data means.

---

### 9.9 Key Takeaway

HTTP request and response bodies carry representations and application data.

The essential model is:

```text
HTTP Message
│
├── Start Line
├── Headers
├── Blank Line
└── Optional Body
```

Key points:

1. A response body carries data returned to the client.
2. A request body carries data sent by the client.
3. `Content-Type` describes the media type of a body.
4. `Content-Length` describes the body length in bytes when used for message framing.
5. JSON, HTML, and plain text can all be transported through HTTP bodies.
6. Request and response bodies belong to different HTTP messages and travel in opposite directions.
7. The presence of application data in a body is not itself a security finding.
8. Understanding bodies is essential before studying forms, APIs, authentication, and vulnerability validation.

The researcher should therefore learn to read an HTTP message as a complete structure rather than focusing only on the URL or status code.
## Part 10 — URL Encoding and Form Encoding

URL encoding is a mechanism for representing data safely within a URL or form-encoded HTTP message.

It is important for a security researcher to distinguish between:

* the original value,
* its encoded representation,
* the decoded value,
* and how the application interprets that value.

Encoding changes representation. It does not automatically make the underlying data safe.

---

### 10.1 Why Encoding Exists

URLs have structural characters with special meanings.

For example:

```text
https://example.com/search?q=web&category=security
```

The `?` separates the path from the query string.

The `=` separates a parameter name from its value.

The `&` separates multiple query parameters.

Because some characters have structural meanings, data containing those characters may need to be encoded when the characters are intended to be part of a value.

For example, suppose the intended value is:

```text
hello & goodbye
```

If the `&` were left unencoded inside a query parameter, it could be interpreted as the beginning of another parameter.

URL encoding provides a representation that distinguishes data from URL structure.

---

### 10.2 Percent-Encoding

Percent-encoding represents certain characters using `%` followed by two hexadecimal digits.

Examples include:

```text
space → %20
&     → %26
/     → %2F
=     → %3D
?     → %3F
```

For example:

```text
hello & goodbye
```

can be represented as:

```text
hello%20%26%20goodbye
```

The encoded representation can then be placed into a URL without treating the `&` as a parameter separator.

---

### 10.3 Spaces and `+`

When data is encoded using the `application/x-www-form-urlencoded` convention, spaces are commonly represented using:

```text
+
```

For example:

```text
hello world
```

can become:

```text
hello+world
```

This is different from general percent-encoding, where a space can be represented as:

```text
%20
```

Therefore, when examining an HTTP request, the researcher should consider which encoding convention is being used rather than assuming that every space must appear as `%20`.

---

### 10.4 Controlled Observation: URL-Encoded Query Parameters

The following controlled request was used:

```bash
curl -sS -G \
  --data-urlencode 'search=hello world' \
  --data-urlencode 'category=web security' \
  -o /dev/null \
  -w 'Effective URL: %{url_effective}\nHTTP version: %{http_version}\nStatus: %{http_code}\n' \
  https://example.com/
```

Observed result:

```text
Effective URL: https://example.com/?search=hello+world&category=web+security
HTTP version: 2
Status: 200
```

The important observation is the transformation:

```text
search=hello world
```

into:

```text
search=hello+world
```

and:

```text
category=web security
```

into:

```text
category=web+security
```

The `+` representation is consistent with the form-style encoding performed by `--data-urlencode`.

The server returned HTTP status `200`, but that status only describes the response to the request. It does not establish how an application would validate, store, or otherwise process those parameter values.

---

### 10.5 Controlled Observation: Reserved Characters

A second controlled request was used:

```bash
curl -sS -G \
  --data-urlencode 'message=hello & goodbye' \
  --data-urlencode 'path=/test/example' \
  -o /dev/null \
  -w 'Effective URL: %{url_effective}\nStatus: %{http_code}\n' \
  https://example.com/
```

Observed result:

```text
Effective URL: https://example.com/?message=hello+%26+goodbye&path=%2Ftest%2Fexample
Status: 200
```

The transformations were:

```text
message=hello & goodbye
```

to:

```text
message=hello+%26+goodbye
```

and:

```text
path=/test/example
```

to:

```text
path=%2Ftest%2Fexample
```

Therefore:

```text
space → +
&     → %26
/     → %2F
```

The `&` inside the `message` value was encoded as `%26`.

This matters because an unencoded `&` has structural meaning in a query string:

```text
?message=value&path=value
```

Encoding the `&` allows it to remain part of the `message` value rather than becoming a parameter separator.

---

### 10.6 Query Parameters Versus Parameter Values

Consider:

```text
https://example.com/?message=hello+%26+goodbye&path=%2Ftest%2Fexample
```

The query contains two parameters:

```text
message=hello+%26+goodbye
path=%2Ftest%2Fexample
```

The encoded representation can be conceptually decoded as:

```text
message = hello & goodbye
path    = /test/example
```

This creates an important distinction:

```text
URL representation
        ↓
Encoded parameter value
        ↓
Decoded parameter value
        ↓
Application processing
```

A security researcher must not assume that the encoded representation and the application's final interpretation are identical.

---

### 10.7 `application/x-www-form-urlencoded`

HTML forms can submit data using the media type:

```text
application/x-www-form-urlencoded
```

A simplified example is:

```http
POST /login HTTP/1.1
Host: example.test
Content-Type: application/x-www-form-urlencoded
Content-Length: 27

username=alice&role=member
```

The request body contains key-value pairs:

```text
username=alice
role=member
```

with `&` separating parameters.

Values containing special characters may be encoded.

For example:

```text
message=hello & goodbye
```

may be represented as:

```text
message=hello+%26+goodbye
```

The server-side application can then decode the representation before processing the values.

---

### 10.8 URL Encoding Versus JSON

URL-encoded form data and JSON are different representations.

Form encoding:

```http
Content-Type: application/x-www-form-urlencoded

crop=maize&growth_stage=vegetative
```

JSON:

```http
Content-Type: application/json

{"crop":"maize","growth_stage":"vegetative"}
```

Both can represent structured data, but they use different syntax and different content types.

A researcher should therefore inspect:

```text
Content-Type
```

before deciding how a request body is represented.

This connects directly to Part 9, where request bodies and `Content-Type` were introduced.

---

### 10.9 Encoding Is Not Validation

A critical security concept is:

> Encoding and validation are different operations.

Encoding answers:

> How should this data be represented so that it can safely travel through this format?

Validation answers:

> Is this data acceptable according to the application's rules?

For example:

```text
admin
```

and:

```text
admin%20
```

are representations of different decoded values.

Likewise, encoding a value does not automatically prevent an application from accepting an inappropriate value.

Therefore:

```text
Encoding ≠ Validation
Encoding ≠ Authorization
Encoding ≠ Sanitization
```

These concepts must not be treated as interchangeable.

---

### 10.10 Decoding and Re-Encoding

During HTTP analysis, the same value may appear in several forms.

For example:

```text
hello & goodbye
```

may appear as:

```text
hello%20%26%20goodbye
```

or, under form-style encoding:

```text
hello+%26+goodbye
```

The researcher should identify:

1. What representation was sent.
2. What representation was received.
3. Whether the application decodes it.
4. What value the application appears to process.
5. Whether the application later encodes the value again.

This becomes especially important when investigating how an application handles input across multiple processing layers.

---

### 10.11 Security Researcher Mental Model

When encountering an encoded parameter, do not immediately treat the encoded value as the application's final value.

Instead, think:

```text
Raw Input
   ↓
Encoding
   ↓
HTTP Request
   ↓
Server / Intermediary
   ↓
Decoding
   ↓
Application Processing
   ↓
Validation / Authorization / Business Logic
```

Different components may process the same representation at different stages.

A useful observation record should therefore distinguish between:

```text
Observed representation
Decoded interpretation
Application behavior
Security impact
```

These are separate observations.

---

### 10.12 Important Distinction: URL Encoding Is Context-Dependent

Encoding appropriate for one context is not automatically appropriate for another.

Examples include:

```text
URL/query encoding
form encoding
HTML encoding
JSON encoding
JavaScript string escaping
```

These mechanisms solve different representation problems.

A researcher should identify the relevant context before interpreting an encoded value.

For example:

```text
%2F
```

is meaningful as percent-encoded data in a URL context.

It should not automatically be treated as an instruction to apply the same decoding rules to every other data format.

---

### 10.13 Connection to Later Security Testing

URL and form encoding become important when analyzing:

* query parameters,
* form submissions,
* API requests,
* redirects,
* application routing,
* authentication flows,
* authorization-related parameters,
* input handling,
* request transformations.

However, recognizing an encoded value is only the beginning of analysis.

The presence of:

```text
%26
%2F
%3D
+
```

is not itself evidence of a vulnerability.

The researcher must determine how the authorized application interprets and processes the value.

---

### 10.14 Verification Checklist

Before considering this part complete, verify:

```text
[ ] I understand why URL encoding exists.
[ ] I understand percent-encoding.
[ ] I understand the role of reserved characters.
[ ] I understand why & may need encoding inside a parameter value.
[ ] I understand why + can represent spaces in form-style encoding.
[ ] I understand application/x-www-form-urlencoded.
[ ] I can distinguish form encoding from JSON.
[ ] I understand encoding versus validation.
[ ] I can identify encoded and decoded representations.
[ ] I understand that encoding alone does not indicate a vulnerability.
```

---

### 10.15 Key Takeaway

URL and form encoding provide representations for transporting data through HTTP structures.

The core mental model is:

```text
Original Value
      ↓
Encoded Representation
      ↓
HTTP Request
      ↓
Decoded Value
      ↓
Application Processing
```

The security-researcher lesson is:

> **Always distinguish representation from interpretation.**

An encoded value tells you how data is represented in the request. It does not, by itself, tell you how the application validates, authorizes, stores, or processes that data.
## Part 11 — Content Types and Content Negotiation

HTTP messages can carry different representations of data.

The `Content-Type` header identifies the media type of the representation being sent, while the `Accept` request header allows a client to express which response media types it prefers.

Understanding these headers is important when analyzing web applications because the same general concept of data can be represented in different formats.

The core relationship is:

```text
Request
│
├── Accept
│     └── Client's preferred response representation
│
└── Request body
      └── Content-Type describes its representation

Response
│
└── Content-Type
      └── Representation actually returned
```

---

### 11.1 What Is a Media Type?

A media type identifies the general format of data being transmitted.

Common examples include:

```text
text/html
text/plain
application/json
application/xml
application/x-www-form-urlencoded
```

A media type consists of a type and subtype:

```text
type/subtype
```

For example:

```text
application/json
```

means that the representation is JSON.

Likewise:

```text
text/html
```

identifies an HTML representation.

The media type provides information that allows the receiving component to determine how the representation should be interpreted.

---

### 11.2 The `Content-Type` Header

`Content-Type` describes the media type of the representation contained in the HTTP message.

For example:

```http
Content-Type: text/html
```

indicates an HTML representation.

A JSON request might contain:

```http
Content-Type: application/json
```

with a body such as:

```json
{"crop":"maize","growth_stage":"vegetative"}
```

A plain-text request might contain:

```http
Content-Type: text/plain
```

with:

```text
hello from the HTTP body lab
```

The important relationship is:

```text
Content-Type
      ↓
describes
      ↓
message representation
```

---

### 11.3 Controlled Observation: Response Content-Type

The following command was used:

```bash
curl -sS -D - -o /dev/null https://example.com/ | \
grep -iE '^(HTTP/|content-type:)'
```

Observed result:

```text
HTTP/2 200
content-type: text/html
```

The response therefore identified its representation as:

```text
text/html
```

The HTTP status and content type provide two different pieces of information:

```text
HTTP/2 200
    ↓
Response status

content-type: text/html
    ↓
Response representation
```

A status code does not replace the information provided by `Content-Type`.

---

### 11.4 The `Accept` Header

`Accept` is a request header used by a client to express which response media types it can accept or prefers.

For example:

```http
Accept: text/html
```

indicates a preference for an HTML response.

Another request might contain:

```http
Accept: application/json
```

indicating a preference for JSON.

The important distinction is:

```text
Accept
   ↓
client preference

Content-Type
   ↓
representation actually sent
```

These headers serve different roles.

---

### 11.5 Controlled Observation: `Accept: text/html`

The following request was used:

```bash
curl -sS \
  -H 'Accept: text/html' \
  -o /dev/null \
  -w 'Accept: text/html\nHTTP version: %{http_version}\nStatus: %{http_code}\nContent type: %{content_type}\n' \
  https://example.com/
```

Observed result:

```text
Accept: text/html
HTTP version: 2
Status: 200
Content type: text/html
```

The client expressed:

```text
Accept: text/html
```

and the response contained:

```text
Content type: text/html
```

The requested preference and returned representation therefore matched in this observation.

---

### 11.6 Controlled Observation: `Accept: application/json`

A second request was used:

```bash
curl -sS \
  -H 'Accept: application/json' \
  -o /dev/null \
  -w 'Accept: application/json\nHTTP version: %{http_version}\nStatus: %{http_code}\nContent type: %{content_type}\n' \
  https://example.com/
```

Observed result:

```text
Accept: application/json
HTTP version: 2
Status: 200
Content type: text/html
```

The client requested:

```text
Accept: application/json
```

but the server still returned:

```text
Content type: text/html
```

This demonstrates that:

> `Accept` expresses a client's preference; it does not guarantee that the server will return that media type.

The server's actual response must therefore be observed rather than inferred from the request.

---

### 11.7 Content Negotiation

Content negotiation is the process through which a client and server can determine an appropriate representation for a response.

A simplified model is:

```text
Client
   │
   │ Accept: application/json
   ▼
Server
   │
   │ selects representation
   ▼
Response
   │
   └── Content-Type: application/json
```

However, a server may choose a different representation depending on its implementation.

Our controlled observation demonstrated:

```text
Accept: application/json
        ↓
Content-Type: text/html
```

Therefore, content negotiation should be treated as an observed application behavior rather than an assumption.

---

### 11.8 Content Negotiation Is Not Limited to `Accept`

HTTP applications can use several mechanisms when determining representations.

Examples include:

```text
Accept
Accept-Language
Accept-Encoding
```

These can express preferences concerning:

```text
media type
language
content encoding
```

For example:

```http
Accept-Language: en
```

can express a preference for English-language content.

Similarly:

```http
Accept-Encoding: gzip, br
```

can indicate supported content encodings.

These headers have different meanings and should not be treated as interchangeable.

---

### 11.9 Request `Content-Type` Versus Response `Content-Type`

`Content-Type` can describe representations in both directions.

For a request:

```http
POST /api/example HTTP/1.1
Content-Type: application/json

{"crop":"maize"}
```

the header describes the **request body**.

For a response:

```http
HTTP/1.1 200 OK
Content-Type: application/json

{"status":"accepted"}
```

the header describes the **response body**.

Therefore:

```text
Request Content-Type
        ↓
What representation the client sent

Response Content-Type
        ↓
What representation the server returned
```

This distinction is particularly important when inspecting API traffic.

---

### 11.10 Controlled Observation: JSON Request Body

The local HTTP body lab was used to observe a JSON request.

The request was:

```bash
curl -sS -X POST \
  -H 'Content-Type: application/json' \
  --data '{"crop":"maize","growth_stage":"vegetative"}' \
  http://127.0.0.1:8001/
```

The local receiver recorded:

```text
Method: POST
Content-Type: application/json
Content-Length: 44
Body: {"crop":"maize","growth_stage":"vegetative"}
```

This demonstrates that the request explicitly declared its body as JSON.

The representation was:

```text
application/json
```

and the transmitted body was:

```json
{"crop":"maize","growth_stage":"vegetative"}
```

---

### 11.11 Controlled Observation: Plain-Text Representation

The same local receiver was then used with:

```bash
curl -sS -X POST \
  -H 'Content-Type: text/plain' \
  --data 'crop=maize&growth_stage=vegetative' \
  http://127.0.0.1:8001/
```

The receiver recorded:

```text
Method: POST
Content-Type: text/plain
Content-Length: 34
Body: crop=maize&growth_stage=vegetative
```

The body therefore contained:

```text
crop=maize&growth_stage=vegetative
```

while the declared media type was:

```text
text/plain
```

This is different from the previous JSON representation even though both requests contain information about the same two conceptual fields.

---

### 11.12 Representation Versus Meaning

The two local observations demonstrate an important concept.

JSON representation:

```text
application/json

{"crop":"maize","growth_stage":"vegetative"}
```

Plain-text representation:

```text
text/plain

crop=maize&growth_stage=vegetative
```

The representation is different.

The application could potentially interpret the two representations differently depending on its implementation.

Therefore:

```text
Representation
      ≠
Application meaning
```

The media type tells the receiver how the sender identifies the representation. It does not by itself tell us everything about how an application will process that data.

---

### 11.13 Content-Type and Parsing

Applications commonly select a parser based on the declared media type.

A simplified model is:

```text
HTTP Request
      │
      ▼
Content-Type
      │
      ▼
Parser
      │
      ▼
Application data
```

For example:

```text
application/json
      ↓
JSON parser
```

while:

```text
application/x-www-form-urlencoded
      ↓
form parser
```

might be used.

This makes `Content-Type` an important observation when analyzing HTTP requests.

The presence of a particular media type is not itself a vulnerability.

The security-relevant question is how the authorized application actually handles the representation.

---

### 11.14 Content-Type and Validation

`Content-Type` identifies representation.

Validation determines whether the application accepts the resulting data according to its rules.

These are different concepts.

For example:

```text
Content-Type: application/json
```

does not automatically mean that the JSON is valid according to the application's business rules.

Similarly:

```text
Content-Type: text/plain
```

does not automatically mean that the content is harmless.

A useful mental model is:

```text
Content-Type
     ↓
Representation identification
     ↓
Parsing
     ↓
Application validation
     ↓
Business logic
```

Each stage performs a different function.

---

### 11.15 Content Negotiation and Security Analysis

Content negotiation can become relevant during authorized security testing because applications may expose different representations depending on request headers.

A researcher may encounter:

```text
Accept: application/json
Accept: text/html
Accept-Language: ...
Accept-Encoding: ...
```

The correct approach is to observe:

1. What request header was sent.
2. What response was returned.
3. Which `Content-Type` the response declared.
4. Whether the response body actually matches that representation.
5. Whether different representations expose different application behavior.
6. Whether the observed behavior has an authorized security impact.

The presence of multiple representations does not automatically indicate a vulnerability.

---

### 11.16 Security Researcher Mental Model

When analyzing content types and negotiation, think in layers:

```text
HTTP Request
      │
      ├── Headers
      │     ├── Accept
      │     └── Content-Type
      │
      └── Body
            │
            ▼
       Representation
            │
            ▼
          Parser
            │
            ▼
     Application Processing
            │
            ▼
         Validation
            │
            ▼
       Business Logic
```

This prevents a common analytical mistake:

> confusing the HTTP representation with the application's interpretation of that representation.

---

### 11.17 Important Distinction: Preference Versus Result

The `Accept` header describes what the client prefers or can accept.

The response `Content-Type` tells us what representation the server actually returned.

Therefore:

```text
Accept
  ≠
Response Content-Type
```

Our controlled experiment demonstrated this directly:

```text
Request:
Accept: application/json

Response:
Content-Type: text/html
```

The observation is valuable precisely because we did not assume that the server would honor the requested format.

---

### 11.18 Connection to Later Security Testing

Content types and content negotiation become important when analyzing:

* web pages,
* REST APIs,
* JSON APIs,
* HTML forms,
* file uploads,
* API clients,
* authentication flows,
* error responses,
* alternate representations,
* request parsing,
* response parsing.

Later security testing may require determining whether an application handles the same logical input differently under different representations.

That analysis must always be performed within the authorized scope of the target.

---

### 11.19 Verification Checklist

Before considering this part complete, verify:

```text
[ ] I understand what a media type is.
[ ] I understand the purpose of Content-Type.
[ ] I understand the purpose of Accept.
[ ] I can distinguish request Content-Type from response Content-Type.
[ ] I understand that Accept expresses a preference.
[ ] I understand that Accept does not guarantee a particular response format.
[ ] I understand basic content negotiation.
[ ] I can distinguish JSON from form-encoded and plain-text representations.
[ ] I understand that Content-Type can influence parsing.
[ ] I understand representation versus application meaning.
[ ] I understand that encoding and representation are not validation.
[ ] I can analyze request and response content types systematically.
```

---

### 11.20 Key Takeaway

HTTP can transport many different representations of data.

The most important concepts are:

```text
Content-Type
    ↓
identifies the representation being sent

Accept
    ↓
expresses a client's preferred response representation

Response Content-Type
    ↓
identifies the representation actually returned
```

The security-researcher mental model is:

> **Observe the declared representation, observe the actual data, and then determine how the application processes it.**

A header is evidence about the HTTP message. It is not, by itself, proof of application behavior or a security vulnerability.
## Part 12 — HTTP Redirects

### 12.1 What Is an HTTP Redirect?

An HTTP redirect is a response in which a server tells the client that the requested resource should be accessed at another location.

Redirects are represented by HTTP `3xx` status codes.

A simplified redirect flow is:

```text
Client
   │
   │ GET /old-location
   ▼
Server
   │
   │ 3xx response
   │ Location: /new-location
   ▼
Client
   │
   │ GET /new-location
   ▼
Server
   │
   │ 200 OK
   ▼
Client
```

The redirect response is a valid HTTP response. It does not necessarily indicate an error.

---

### 12.2 Common Redirect Status Codes

Common HTTP redirect status codes include:

| Status | Meaning            |
| ------ | ------------------ |
| `301`  | Moved Permanently  |
| `302`  | Found              |
| `303`  | See Other          |
| `307`  | Temporary Redirect |
| `308`  | Permanent Redirect |

These status codes have different semantics, particularly around whether the redirect represents a permanent or temporary change and how the original request method is handled.

The important foundation-level concept is that a redirect is represented by a `3xx` response and normally includes information identifying the next location.

---

### 12.3 The `Location` Header

The `Location` response header identifies the destination of a redirect.

For example:

```http
HTTP/2 302
Location: /get
```

The destination can be represented as a relative reference such as:

```http
Location: /get
```

or as an absolute URL such as:

```http
Location: https://example.com/new-location
```

The client resolves the destination and may issue another request.

---

### 12.4 Controlled Observation: Initial Redirect Response

The following command was used to observe a redirect without following it:

```bash
curl -sS -D - -o /dev/null https://httpbin.org/redirect/1
```

Observed response:

```http
HTTP/2 302
date: Fri, 18 Sep 2026 18:02:13 GMT
content-type: text/html; charset=utf-8
content-length: 215
server: gunicorn/19.9.0
location: /get
```

The important fields were:

```text
HTTP/2 302
Location: /get
```

This demonstrates that the server returned a redirect response and identified `/get` as the next location.

The request did not reach the final resource because `curl` was not instructed to follow the redirect.

---

### 12.5 Redirect Behavior Without `-L`

The following command was used to inspect the resulting status and effective URL:

```bash
curl -sS -o /dev/null \
  -w 'Status: %{http_code}\nEffective URL: %{url_effective}\n' \
  https://httpbin.org/redirect/1
```

Observed result:

```text
Status: 302
Effective URL: https://httpbin.org/redirect/1
```

This demonstrates that, by default, `curl` reports the redirect response rather than automatically following it.

The effective URL remains the original requested URL.

---

### 12.6 Redirect Following With `-L`

`curl` can be instructed to follow redirects with the `-L` option.

The following command was used:

```bash
curl -sS -L -o /dev/null \
  -w 'Status: %{http_code}\nEffective URL: %{url_effective}\n' \
  https://httpbin.org/redirect/1
```

Observed result:

```text
Status: 200
Effective URL: https://httpbin.org/get
```

The client therefore followed the redirect and reached the final resource.

The observed sequence was:

```text
https://httpbin.org/redirect/1
        │
        │ 302
        │ Location: /get
        ▼
https://httpbin.org/get
        │
        │ 200
        ▼
Final response
```

---

### 12.7 Controlled Observation: Complete Redirect Chain

The complete redirect chain was observed with:

```bash
curl -sS -L -D - -o /dev/null \
  https://httpbin.org/redirect/1
```

Observed responses:

```http
HTTP/2 302
date: Fri, 18 Sep 2026 18:03:55 GMT
content-type: text/html; charset=utf-8
content-length: 215
server: gunicorn/19.9.0
location: /get
```

followed by:

```http
HTTP/2 200
date: Fri, 18 Sep 2026 18:03:56 GMT
content-type: application/json
content-length: 254
server: gunicorn/19.9.0
```

This demonstrates that following a redirect can produce multiple HTTP responses within one client operation.

The first response was:

```text
302 Found
```

and identified:

```text
Location: /get
```

The subsequent request reached:

```text
200 OK
```

with:

```text
Content-Type: application/json
```

---

### 12.8 Redirect Response Versus Final Response

A redirect response and its final response are separate HTTP responses.

The observed chain was:

```text
Response 1
────────────────────────
HTTP/2 302
Location: /get
Content-Type: text/html
────────────────────────

          ↓

Request 2
────────────────────────
GET /get
────────────────────────

          ↓

Response 2
────────────────────────
HTTP/2 200
Content-Type: application/json
────────────────────────
```

This distinction matters when analyzing HTTP traffic.

A browser or HTTP client may perform several requests before displaying the final resource.

Therefore, seeing a `200 OK` in a browser does not necessarily mean that the original URL directly returned the final resource.

---

### 12.9 Redirects and Client Behavior

Different clients and tools can handle redirects differently.

For example:

```text
curl
```

does not automatically follow redirects unless instructed with:

```text
-L
```

A browser normally follows ordinary redirects automatically.

This creates an important distinction:

```text
Server behavior
        +
Client behavior
        =
Observed redirect flow
```

When analyzing an application, it is therefore useful to know whether the tool is showing only the initial response or the entire redirect chain.

---

### 12.10 Redirect Chains

A single redirect is not the only possible pattern.

An application can produce multiple redirects:

```text
Request
   │
   ▼
302
Location: /step-1
   │
   ▼
302
Location: /step-2
   │
   ▼
301
Location: /final
   │
   ▼
200 OK
```

Each redirect represents another HTTP response and potentially another request.

Redirect chains can therefore be inspected as a sequence rather than as one isolated status code.

---

### 12.11 Redirects and HTTP Methods

Redirect behavior can interact with the HTTP method used by the original request.

For example:

```text
GET
POST
PUT
PATCH
DELETE
```

do not necessarily have identical redirect semantics.

The `307` and `308` status codes are particularly important because their semantics preserve the original request method and request body when the redirect is followed.

This becomes important when analyzing applications that redirect requests involving state-changing operations.

At this stage, the goal is to understand the protocol behavior rather than test a live application.

---

### 12.12 Redirects and Security Analysis

A redirect is not automatically a security vulnerability.

The security-relevant questions depend on the application.

Examples of questions a researcher may eventually ask include:

* Where does the redirect destination come from?
* Is the destination controlled by the server or influenced by user input?
* Does the application validate redirect destinations?
* Does authentication state survive the redirect appropriately?
* Does sensitive information appear in the URL?
* Does a redirect expose information through query parameters?
* Does the application create unexpected redirect chains?
* Does the redirect change security-relevant behavior?

These questions belong to later vulnerability-analysis stages.

The presence of:

```http
HTTP/2 302
Location: /get
```

by itself is not evidence of a vulnerability.

---

### 12.13 Redirects and Authorization Boundaries

Redirect behavior must also be interpreted within the authorization boundary.

A redirect discovered during reconnaissance does not automatically authorize testing the destination.

The distinction remains:

```text
Discovered
    ≠
Authorized
```

If a redirect points to another hostname, the destination must still be evaluated against the applicable scope before any testing is performed.

Reachability through a redirect does not establish authorization.

---

### 12.14 Researcher Mental Model

When encountering a redirect, think in terms of:

```text
Original Request
       │
       ▼
HTTP Status
       │
       ▼
Location Header
       │
       ▼
Client Redirect Behavior
       │
       ▼
Follow-up Request
       │
       ▼
Final Response
```

The researcher should record the complete sequence when the redirect chain is relevant.

Useful observations include:

* original URL
* original HTTP method
* redirect status code
* `Location` value
* destination URL
* follow-up method
* final status code
* final response content type
* number of redirects
* whether the destination remains within authorized scope

---

### 12.15 Important Distinction: Redirect Versus Rewrite

A redirect tells the client to make another request.

A server-side rewrite can instead route the request internally without telling the client that the resource changed.

Conceptually:

```text
Redirect:

Client
  │
  │ Request A
  ▼
Server
  │
  │ 302 Location: /new
  ▼
Client
  │
  │ Request B
  ▼
Server
```

versus:

```text
Internal routing:

Client
  │
  │ Request A
  ▼
Server
  │
  │ Internal routing
  ▼
Application resource
```

The client-visible HTTP behavior is therefore different.

This distinction becomes useful when interpreting application routing and proxy behavior.

---

### 12.16 Security Researcher Mental Model for Redirects

A useful sequence is:

```text
OBSERVE
   ↓
IDENTIFY STATUS
   ↓
READ LOCATION
   ↓
CHECK CLIENT BEHAVIOR
   ↓
TRACE FOLLOW-UP REQUEST
   ↓
INSPECT FINAL RESPONSE
   ↓
CHECK AUTHORIZED SCOPE
   ↓
FORM HYPOTHESIS
```

Do not jump directly from:

```text
3xx response
```

to:

```text
vulnerability
```

The redirect is an HTTP behavior that must be understood in its application context.

---

### 12.17 Connection to Later Bug Bounty Work

Redirects are relevant to several later areas of web security research.

They can appear during:

* authentication flows
* login/logout processes
* authorization checks
* URL routing
* OAuth/OIDC flows
* API workflows
* canonicalization
* HTTP-to-HTTPS transitions
* application migrations
* proxy and CDN routing

Later lessons can build on this foundation to investigate security properties of redirect destinations and redirect handling.

---

### 12.18 Verification Checklist

Before considering this part complete, verify that you can explain:

* [ ] What an HTTP redirect is.
* [ ] What `3xx` status codes represent.
* [ ] The purpose of the `Location` header.
* [ ] The difference between `302` and `200` in the observed chain.
* [ ] What `curl -L` does.
* [ ] What happens when `curl` does not follow a redirect.
* [ ] How to observe a complete redirect chain.
* [ ] Why the redirect response and final response are separate responses.
* [ ] Why redirect behavior can depend on the client.
* [ ] Why a redirect is not automatically a vulnerability.
* [ ] Why a redirect destination must still be evaluated against authorization scope.
* [ ] The difference between a client-visible redirect and internal server-side routing.

---

### 12.19 Key Takeaway

An HTTP redirect is a client-visible instruction to continue a request at another location.

The core pattern is:

```text
3xx Response
     +
Location Header
     ↓
Follow-up Request
     ↓
Final Response
```

The controlled observation demonstrated:

```text
GET /redirect/1
        │
        ▼
HTTP/2 302
Location: /get
        │
        ▼
GET /get
        │
        ▼
HTTP/2 200
Content-Type: application/json
```

The key lesson is:

> **A redirect is part of an HTTP request/response sequence, and understanding the complete sequence is more useful than looking only at the final response.**
