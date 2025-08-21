---
date: '2025-08-21T15:05:25-04:00'
draft: true
title: 'How to Debug a Goroutine'
---

Debugging concurrent code can be pretty tricky.

## Using breakpoints

## Using `GOMAXPROCS`

## You can't enforce an order (at least not easily)

I limited my `GOMAXPROCS` to 1 and clicked through every execution of each goroutine but wound up getting a 
non-deterministic order every time.

This is because as soon as a function is executed as a goroutine, it's a free-for-all in terms of which goroutine
gets scheduled first. Even if it appears that your concurrent code is executing sequentially, this is purely
a coincidence and cannot be relied on to happen everytime.
