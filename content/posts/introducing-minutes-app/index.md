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

## Session groups and tags

A __Session group__ can be thought of as a broad container for sessions. They allow sessions to be categorized together despite having 
disparate application or metadata attributes.

A __tag__ can be added to a session group and is a "regex-y" way to match any or all pieces of a session's metadata. It
is a combination of _application_ and _metadata_ attributes. Both attributes support a basic query language somewhat
akin to regex like:

- `application: B*`, `metadata: *Blender*`: all sessions that have an application that starts with `B` and metadata
  that has a substring of `Blender` anywhere in it.

For example, let's say I have a personal goal of "Creating an animated movie". This is a large project that doesn't 
cleanly fit into one type of session (application + metadata). During the course of working on this goal, I could be
using any of the following:

1. Google Chrome - Blender tutorial
2. Blender - Project A
3. Blender - Project B
4. Ableton - Project A intro music
5. Notion - Project A character notes
6. etc.

There are a lot of different programs that go into a single project. The idea behind session groups and tags is that
we want to be able to unify sessions together that match a metadata pattern in order to aggregate time spent for a given
session group.

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
