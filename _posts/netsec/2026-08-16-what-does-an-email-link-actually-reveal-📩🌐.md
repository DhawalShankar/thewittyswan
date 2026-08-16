---
title: What Does an Email Link Actually Reveal?📩🌐
date: 2026-08-16 21:05:00 +05:30
categories:
  - netsec
layout: post
---
Hello! I’m TheWittySwan, and this week I got curious about something most of us do every day without thinking twice: **clicking a link in an email.**

We hear about IP addresses, proxies and geolocation all the time. But what does a website actually see when you click a link? Does it see *your* IP? Does a map show exactly where you are?

I decided to find out through a small experiment.

## Section 1: An Email Open Is Not Always a Direct Connection

Email tracking can use a tiny image embedded inside a message.

Something as simple as:

When the email is opened, that image has to be requested.

It might seem like this:

But modern email providers can add another layer.

Some providers fetch email images through their own proxy infrastructure:

In that situation, the tracking server may see the provider's infrastructure rather than the recipient's network address.

That is an important distinction.

A location shown for an email open may therefore represent the **server fetching the image**, not the person reading the email.

## Section 2: Then I Tried a Link

A link is a little different.

Suppose an email contains:

When the link is clicked, the browser has to make a web request.

A tracking system can put a redirect in front of the destination:

The tracking endpoint can record information about the request before redirecting the visitor.

In my experiment, the resulting record included things such as:

* Timestamp
* Device type
* Operating system
* Browser
* Country
* Approximate city
* Map location

This was considerably different from simply opening an email.

## Section 3: But Is the Map Actually Showing Where You Are?

This was the most interesting part.

I knew exactly where I was when I performed the test.

The map showed a nearby but different part of the same metropolitan region.

At first, that looks like an error.

But IP geolocation does not work like GPS.

The process is more like:

The public IP address may be registered to an ISP gateway or network location that is different from the physical location of the user.

So:

> **IP location is not device location.**

A map pin can be useful for understanding the general network region while still being wrong about the user's actual physical position.

## Section 4: I Tried Different URLs

Naturally, I tried a few different destinations.

For example:

Most behaved exactly as expected.

Then I tried a URL using a `www` subdomain:

That particular link did not appear in the tracking results.

Changing the URL to another form made it work.

This was a useful reminder that **URL processing matters**.

A domain, its `www` version, HTTP/HTTPS variants, redirects and the way a tracking service rewrites links can all produce different behaviour.

The Internet rarely has only one layer.

## Section 5: What Can Actually Be Learned?

A tracking request can potentially reveal information such as:

* Source network IP
* Timestamp
* Browser
* Operating system
* Device type
* Approximate geographic region

But there is a major difference between **network information** and **personal location information**.

An IP address does not automatically reveal:

* Exact GPS coordinates
* Exact house location
* The identity of the person
* Where the person is physically standing

There can be NAT, shared connections, proxies, VPNs and other layers between a device and the public Internet.

## Section 6: Why the Timestamp Matters

Suppose a server records:

That is much more useful than simply saying:

> "Someone from Delhi clicked this."

The IP identifies a network endpoint, while the timestamp tells us **when** that endpoint made the request.

In legitimate investigations, those details can potentially be correlated with network-provider records through the appropriate legal process.

But even then, the IP-based map is only one piece of the puzzle.

## Section 7: The Little Experiment That Changed My Understanding

The fascinating thing was that the experiment required almost nothing complicated.

An email.

A link.

A browser.

And a server.

Yet underneath one ordinary click was an entire chain:

And somewhere in that chain, a network address became an approximate point on a map.

It is tempting to look at that point and think:

> **"That's where the person is."**

But the more accurate statement is:

> **"That's where the network address is estimated to be."**

That small difference is important.

The Internet is full of information that looks precise until you understand how it was obtained.

And that is exactly why I enjoy taking these little systems apart.

Sometimes the best way to understand a network is simply to click a link and watch what happens next.

That's all from TheWittySwan this weekend.

See you next week.

**Signing out, happy browsing!!** 🦢🌐
