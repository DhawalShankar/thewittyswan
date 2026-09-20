---
layout: default
title: Projects
permalink: /projects/
---
# projects

## [thewittyswan — personal writing & creative engineering platform](https://thewittyswan.space)

this is where i write, build, experiment, and occasionally hide things that probably didn't need to exist.

- built a jekyll-based publishing space for essays, poetry, reflections, and technical writing.
- built a custom interactive terminal using **go + xterm.js**, turning a writing website into something visitors can explore rather than simply read.
- added a security-checking workflow that lets curious visitors inspect the security posture of websites.
- deliberately built the site at the intersection of literature and software — a place where the medium itself can become part of the story.
- **impact:** a personal corner of the internet where writing and engineering don't have to live in separate rooms.
- **built with:** jekyll · go · xterm.js · javascript · linux

---

## [golangforall — go developer community & learning platform](https://golangforall.in)

what started as an attempt to make go learning feel less intimidating became a community for people who learn, build, teach, and contribute with go.

- built the platform from the ground up using docusaurus, react, a custom go backend, postgresql, and cloudinary.
- created an authenticated publishing system for technical writing, build logs, meetups, announcements, and community updates.
- built a lightweight content-management console with protected administrative operations and cloud-backed media uploads.
- made **golab** part of the ecosystem, giving the community a place to move from reading go to actually running it.
- **impact:** turned a personal interest in go into a growing community platform connecting learning, writing, projects, and people.
- **built with:** go · react · docusaurus · postgresql · cloudinary · docker · aws · caddy · systemd

---

## [golab — sandboxed go code execution playground](https://golab.golangforall.in)

i wanted to know what would happen if a learning platform didn't just *show* you go code, but actually gave you a place to run it.

the problem was obvious: **how do you execute arbitrary code without trusting the person submitting it?**

- built a browser-to-container execution pipeline using monaco editor, dedicated stdin, a go http runner, and docker.
- treated every submission as hostile: non-root containers, dropped linux capabilities, disabled networking, and per-request cpu, memory, and pid limits.
- deployed the execution engine on aws ec2, with caddy handling tls and reverse proxying and systemd managing the runner.
- added a persistent go build cache to reduce compilation overhead during repeated executions.
- **impact:** created a real, publicly accessible go playground where untrusted code can execute inside a deliberately constrained environment.
- **built with:** go · docker · aws ec2 · caddy · systemd · next.js · monaco editor

---

## [vartalang — language exchange & career platform](https://vartalang.in)

what if learning a language meant finding another person rather than opening another lesson?

vartalang connects people who can teach each other, and then takes that connection a little further into the world of work.

- built real-time communication with socket.io, including rooms, message persistence, and read receipts.
- implemented hybrid jwt + oauth 2.0 authentication with rbac across platform workflows.
- engineered reciprocal matching across **22 languages**, using mongodb compound queries and unique indexes to prevent duplicate relationships.
- added ttl-based expiry for temporary matching data and cron-driven job expiry for stale opportunities.
- **impact:** combined language exchange, real-time conversation, matching, and career discovery into one platform.
- **built with:** next.js · node.js · express.js · socket.io · mongodb · jwt · oauth 2.0 · vercel · render

---

## [cosmo india prakashan — e-commerce & ai inventory platform](https://cosmoindiaprakashan.in)

this one began with books.

it eventually became an experiment in building the infrastructure behind a small publishing business — payments, inventory, databases, and an ai assistant for people who don't want to think in database queries.

- integrated razorpay with hmac-sha256 signature verification for cryptographically validated payment callbacks.
- used mongodb for orders and supabase postgresql for the catalog, choosing storage around the workload rather than forcing everything into one database.
- built a gemini-powered natural-language inventory interface for non-technical staff.
- protected administrative operations with jwt and rbac while designing the ai interaction to resist prompt-injection attempts.
- **impact:** turned a traditional publishing operation into a live digital storefront with payment infrastructure, structured inventory, and an ai-assisted operational layer.
- **built with:** react · typescript · node.js · express.js · mongodb · postgresql · razorpay · gemini api · render

---

## [school records — digital records & ocr platform](https://capecomorinschool.com)

decades of handwritten school records shouldn't require someone to spend an afternoon looking through a cupboard.

this project was about turning that paper archive into something searchable.

- built an ocr pipeline using gemini's multimodal capabilities to extract information from scanned handwritten student records.
- used rapidfuzz to deal with imperfect ocr output and match extracted names against existing records.
- reduced student and admission-record lookup from **hours to roughly 30 seconds**.
- built authenticated administrative panels with firebase jwt authentication and rbac for **10+ staff members**.
- **impact:** converted a manual, paper-heavy retrieval process into a searchable digital workflow for school staff.
- **built with:** next.js · flask · fastapi · gemini · rapidfuzz · firebase auth · postgresql · turso · cloudinary

---

## [auralace — audio processing playground](https://auralace.vercel.app)

a small experiment in making sound something you can manipulate and understand immediately.

- built an interactive interface for experimenting with time stretching, smoothing, and depth-oriented audio transformations.
- designed the experience around immediate before-and-after playback rather than hiding processing behind a batch workflow.
- made changes to the sound directly perceptible instead of reducing them to numbers on a screen.
- **impact:** turned abstract audio-processing operations into an interactive experiment that can be heard rather than merely described.
- **built with:** javascript · web audio api · react · vercel

---

## [churn — ai-powered developer cli](https://pypi.org/project/churn-cli/)

sometimes the fastest way to understand a repository is to stay in the terminal.

churn is an open-source experiment in bringing llm-assisted repository analysis into that environment.

- built a cli for interview preparation, documentation generation, and repository health analysis across local and github repositories.
- integrated **gemini, groq, and openai** rather than coupling the tool to a single model provider.
- designed the workflow around the terminal so analysis happens where developers already work.
- published the package to pypi, reaching approximately **144 monthly downloads**.
- **impact:** turned repository analysis and ai-assisted developer workflows into a reusable command-line tool.
- **built with:** python · gemini api · groq api · openai api · pypi · cli
