---
date: '2025-08-14T16:20:30-04:00'
draft: true
title: '5 steps to get up to speed with a new Go package'
---

# Intro

# Body

## 1. Have ChatGPT generate a tiny, runnable example

## 2. Add breakpoints
Breakpoints are _superior_ to logging statements. Why? Because a log line will simply print whatever you gave it, at 
which point the program will continue to blaze right through to the end. 

If you didn't log the right thing or if the log you added was less helpful than you thought, tough luck. You'll have to 
restart and/or wait until the main process gets back to that part of the code again.

A __breakpoint__ will actually force the code to pause and allow you to examine ALL entities that are within scope.
You can click through, look at attributes, have the code execute line-by-line, step further in to function/method calls, 
etc.

- Read the tests
- Find an entrypoint and add a debugger
- Have 2 versions of your idea: the big, glorious version and the stripped down, toy version.
- have a Golang scratch repo
- Make sure your Go tooling is up-to-date and working (LSP, syntax completion, etc.).
- Use ChatGPT or other AI tool.

# 
