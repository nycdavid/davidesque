---
date: '2026-01-06T06:58:26-05:00'
draft: false
title: 'Introducing: The Minutes App'
---

For the last few weeks, I've been building a macOS application that I want to be able to use to track where I spend my 
time on the computer during a given day.

The app is called [minutes](https://github.com/nycdavid/minutes) and my only plans are for it to run as a standalone 
Go binary.

I'll let this blog post function as a README for the app, of sorts.

# Concepts

- Entirely computer-based. Designed to track how one spends their time on the computer, i.e. which window is in focus at
  particular times of the day.
- Heartbeats are sent for as long as a user isn't idle.
- Heartbeat consists of:
  - Application in focus
  - Metadata provided by the OS
  - Timestamp

# Data aggregation

The eventual goal is to be able to piece together a complete picture of how someone spends their time on their computer.
For folks whose entire livelihood and hobbies, at least from a productivity standpoint, all revolve around
computer-based work, collecting as much data around computer usage habits does a pretty good job of illustrating how
my time is spent.

## Application - Metadata combinations

Generally my goals on a computer typically encompass 2-3 apps that are used in a specific way. For instance: I want to
learn the Blender 3D modeling software. What that means is that when I'm practicing Blender, I'll actually have several
applications open:

1. Blender, itself (of course)
2. Chrome playing some kind of Blender tutorial video
3. Possibly a Blender tutorial book open in Chrome or Preview

When I look back at this aggregated data, I don't want to see 3 separate bar charts that interleave with one another.
I want to see high level "Blender" bar chart that shows total time spent and an option to break this bar chart up into
the individual time spent in each "Blender"-related app.

That means that I need to be able to classify certain App-Metadata combinations as feeding into a higher-level category.

Additionally, I want this to be user-customizable, so I need to build a system that allows users to create their own
App-Metadata combinations.
