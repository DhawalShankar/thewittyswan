---
title: I Watched a File Travel Across My Network 🦈
date: 2026-08-26 23:00:00 +05:30
categories:
  - netsec
layout: post
---
Hello! I’m **TheWittySwan**, and this week I got curious about something much closer to the metal than clicking a tracking link:

> **If I transfer a file between two devices on my own network, what can an observer actually see?**

We hear *packet sniffing*, *Wireshark*, *TCP*, and *network interception* thrown around constantly. But seeing those words in a textbook is very different from watching an actual file travel across a network.

So I built a tiny lab.

- - -

## Section 1: Building the Smallest Possible Network Lab

I used:

* An Android phone running **Termux**
* A Windows laptop
* The phone's hotspot
* Wireshark
* `curl`

Nothing exotic.

On the phone, I created a small test directory and started a Python HTTP server:

```bash
python -m http.server 8000
```

The phone was now effectively saying:

> “If someone connects to port 8000, I'll serve files from this directory.”

My Windows machine could then request a file:

```powershell
curl.exe http://10.224.108.91:8000/test.txt
```

And just like that, the file travelled from the phone to the laptop.

That sounds trivial.

But then I asked:

> **What exactly travelled across the network?**

- - -

## Section 2: Enter Wireshark 🦈

I opened Wireshark on Windows.

Initially, I made a classic beginner's mistake: I captured the **loopback interface**.

So instead of seeing:

```text
Phone → Wi-Fi → Laptop
```

I was seeing:

```text
127.0.0.1 → 127.0.0.1
```

Nothing was wrong with Wireshark.

**I was simply looking at the wrong interface.**

Once I selected the actual Wi-Fi interface, things became much more interesting.

I filtered the traffic with:

```text
tcp.port == 8000
```

Then I downloaded the file again.

This time, Wireshark caught the entire conversation.

- - -

## Section 3: Watching TCP Build a Connection

The first thing I saw was:

```text
SYN
SYN, ACK
ACK
```

The famous **TCP three-way handshake**.

In simple terms:

```text
Laptop → Phone     “Can we connect?”
Phone → Laptop     “Yes, I’m here.”
Laptop → Phone     “Great.”
```

Only after establishing the TCP connection did the actual HTTP request appear.

And then I saw:

```http
GET /test.txt
```

My laptop was literally asking the phone:

> **“Give me `test.txt`.”**

The phone responded with:

```http
HTTP/1.0 200 OK
```

And then the file data started travelling.

Suddenly, TCP and HTTP weren't abstract concepts anymore.

I was watching them happen.

- - -

## Section 4: I Downloaded an Actual ZIP

I wanted something larger than a tiny text file.

So I requested a ZIP archive:

```powershell
curl.exe "http://10.224.108.91:8000/WhatsApp%20Chat%20with%20Joey.zip" -o test2.zip
```

Wireshark captured it.

The HTTP response contained:

```text
HTTP/1.0 200 OK
Content-type: application/zip
Content-Length: 2427
```

And then came the interesting part.

The ZIP didn't appear as one giant packet.

The data was carried through **multiple TCP segments**.

Wireshark even showed that the TCP data had to be **reassembled**.

That's when another idea clicked:

> **A file isn't really travelling across the network as a “file”.**

At the network level, it's bytes being transported through a sequence of protocols and packets.

- - -

## Section 5: Following the Conversation

I selected the HTTP request and used:

**Follow → TCP Stream**

And suddenly the individual packets became a conversation.

At the beginning:

```http
GET /WhatsApp%20Chat%20with%20Joey.zip
```

Then:

```http
HTTP/1.0 200 OK
Content-type: application/zip
```

And after that came the ZIP's binary data.

I even saw:

```text
PK
```

at the beginning of the ZIP data—the familiar ZIP file signature.

The rest looked like complete nonsense because I was viewing **compressed binary data as text**.

And that was the point.

Wireshark wasn't displaying some magical representation of “the file”.

It was showing me the **bytes that were actually transmitted**.

- - -

## Section 6: Could Wireshark Reconstruct the File?

Yes.

Wireshark provides:

**File → Export Objects → HTTP**

When HTTP traffic contains a transferred file, Wireshark can sometimes reconstruct and export that object.

![Wireshark-Interface](https://res.cloudinary.com/daglyjaqu/image/upload/v1787765806/Screenshot_2026-08-26_222312_xkxqc7.png "TCP Packets Captured")

So conceptually:

```text
Packets
   ↓
TCP stream
   ↓
HTTP response
   ↓
Reassembled bytes
   ↓
Original file
```

That's a pretty powerful demonstration.

Not because Wireshark is “hacking” anything.

But because it makes something invisible—the network transfer—**observable**.

- - -

## Section 7: And Then Came the Security Question

At this point I asked:

> **If I can reconstruct a file from captured HTTP traffic, could this work against someone else's traffic?**

The answer is: **it depends heavily on the environment and encryption.**

Our experiment worked because I deliberately used **plain HTTP**.

HTTP sends application data without TLS encryption.

HTTPS is different:

```text
Application data
       ↓
      TLS
       ↓
Encrypted traffic
       ↓
     Network
```

So a packet capture can still reveal things like:

* IP addresses
* ports
* timing
* packet sizes
* connection information

but the application payload is normally protected by encryption.

That's a massive difference.

- - -

## Section 8: The Most Important Mistake I Made

There was another lesson hiding in the experiment.

At one point, I started the Python server from a directory containing **far more files than I intended to expose**.

The directory listing revealed PDFs, images, videos and other files.

That was a beautiful security mistake.

The server wasn't malicious.

The network wasn't malicious.

**My configuration was simply wrong.**

I had effectively told the server:

> “Everything underneath this directory is available.”

That taught me something much more useful than another Wireshark filter:

> **A service only knows the boundaries you give it.**

A harmless tool can become a serious data-exposure problem when configured carelessly.

- - -

## Section 9: What Did I Actually Learn?

I started this experiment thinking:

> **“Packet sniffing means looking at other people's traffic.”**

I finished it with a very different understanding.

Packet analysis is about asking:

```text
Who communicated?
       ↓
With whom?
       ↓
Using which protocol?
       ↓
When?
       ↓
What happened?
       ↓
What data crossed the network?
       ↓
Was it encrypted?
       ↓
Can the conversation be reconstructed?
```

And that is much closer to how I now understand **Network Security**.

Wireshark isn't a magic hacking button.

It's more like a **microscope for network behaviour**.

- - -

## Section 10: One Tiny Lab, A Much Bigger Picture

My entire experiment was basically:

```text
Android / Termux
      │
      │ HTTP
      │
   Wi-Fi hotspot
      │
      ▼
Windows laptop
      │
      ▼
   Wireshark
```

Yet inside that tiny setup were:

**IP addressing**

**TCP**

**Three-way handshake**

**HTTP**

**File transfer**

**TCP segmentation**

**TCP reassembly**

**Packet capture**

**Stream reconstruction**

**Plaintext vs encryption**

**Service exposure**

**Filesystem permissions**

That's what I love about networking.

Something as ordinary as:

```powershell
curl.exe http://10.224.108.91:8000/test.txt
```

can open the door to an entire world underneath.

And perhaps the biggest lesson I took away is this:

> **Don't just learn what a network protocol is. Make two machines use it, capture what happens, and then explain every packet.**

That's when networking stops being theory.

It becomes something you can **see**.

That’s all from TheWittySwan this week.

See you next time.

**Signing out, happy capturing!!** 🦢📡
