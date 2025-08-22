---
date: '2025-08-21T15:05:25-04:00'
draft: true
title: 'How to Debug a Goroutine'
---

Debugging concurrent code can be pretty tricky.

## Note about editors/IDEs

With Go, my philosophy on editors vs. IDEs vs. whatever else is this: if your current setup won't allow you to easily add
breakpoints, granularly step through code line-by-line and dive in to and out of function calls, change your setup to
one that does. Immediately.

The boost in productivity you'll experience immediately by using breakpoints rather than print statements and just 
trying to read the code and make sense of it in your head will be nothing short of miraculous.

Luckily, most editors and IDEs (vim, VS Code, etc.) coupled with the right plugins and tooling should get you there.

## Using breakpoints

## Using `GOMAXPROCS`

`GOMAXPROCS` is an environment variable that the runtime looks at to determine how many goroutines it will allow to 
make simultaneous progress at any one time.

## You can't enforce an order (at least not easily)

I limited my `GOMAXPROCS` to 1 and clicked through every execution of each goroutine but wound up getting a 
non-deterministic order every time.

This is because as soon as a function is executed as a goroutine, it's a free-for-all in terms of which goroutine
gets scheduled first. Even if it appears that your concurrent code is executing in the order that it happens to be 
written, this is purely a coincidence and cannot be relied on to happen every time.

Not only that, but the concept of "preemption" also takes effect with goroutines:

> __Preemption__ means the scheduler can pause a running goroutine and switch execution to another, even if the goroutine hasn’t voluntarily yielded (e.g. by blocking on I/O or a channel).

What this means for debugging is that, although we can have goroutines execute 1 at a time, there's no guarantee that
they'll execute in the order that they were created. It sounds obvious but if the code can only be debugged and 
understood if executed in a specific order, strongly consider just writing it sequentially. The problem might just 
be a bad fit for concurrency.

---

### Async synchronous code
That being said, I like to experiment. So I asked myself what would code that's written concurrently but must 
execute sequentially look like?

__WARNING: The following code is _terrible_. No one should ever write anything that remotely resembles it.__
