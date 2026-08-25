---
date: '2026-08-23T06:00:00-04:00'
draft: true
title: '6 Pen Pressure Recipes for Different Drawing Styles in Clip Studio Paint'
description: 'Ballpoint pen, brush calligraphy, spray paint, and more: the specific Dynamics settings that get you each look in Clip Studio Paint, and why each one works the way it does.'
url: '/clip-studio-paint-pen-pressure-recipes/'
categories: ["Clip Studio Paint", "Art"]
---

<!-- cover image once captured: a strip showing all 6 stroke styles side by side -->

Every recipe below is the same idea applied six different ways: pick a property, decide which input drives it
(pressure, tilt, or velocity), and decide how far that input is allowed to push it. That's the whole per-brush
__Dynamics__ system covered in
[Pen Pressure Settings Explained: Global vs. Per-Brush](/clip-studio-paint-pen-pressure/). I'm not re-explaining
the mechanics here, just pointing at exactly which knob produces each look and why.

Treat every number below as a starting point, not a tested constant. Your tablet's own pressure curve, your
brush's base size, and your hand all shift where these land, so nudge by eye once you're in the ballpoint.

## 1. Ballpoint pen

__The look:__ a mostly flat, consistent line that barely reacts to how hard you press, the way an actual
ballpoint does, but not perfectly rigid: real ballpoint strokes still show a hair of taper right where the pen
first touches down and where it lifts off.

__The setting:__ the setting that actually matters here isn't Minimum Value, it's brush size. Set the brush
itself small, around 2-4px, and leave pressure linked to Size like normal. Minimum Value barely matters at this
scale, even at 0 it still reads as a ballpoint with a small natural taper.

__Why it looks like this:__ Minimum Value is a percentage of the brush's configured size, not a fixed pixel
amount. On a 50px brush, the gap between Minimum Value 0 and 100 spans dozens of visible pixels. On a 3px brush,
that same percentage range is a fraction of a pixel, too small for CSP to render as a visible difference no
matter where you set it. So a thin brush looks "pressure-insensitive" almost by default, and the sliver of taper
you do see at the start and end of a stroke is really just the pen making initial contact and lifting off, not
something Minimum Value is doing. See [the Minimum Value post](/clip-studio-paint-minimum-value/) for what that
setting is actually doing at brush sizes where it's big enough to matter.

![Clip Studio Paint Brush Size Dynamics panel for a ballpoint pen recipe showing brush size set to 3.0 and pen pressure Minimum Value at 0 with a straight linear pressure curve](clip-studio-paint-ballpoint-pen-brush-size-dynamics-settings.png#center)

![Clip Studio Paint ballpoint pen stroke example, cursive handwriting in blue ink showing a consistent line weight with a subtle taper at the stroke tips](clip-studio-paint-ballpoint-pen-stroke-example.png#center)

## 2. Japanese brush calligraphy

__The look:__ thick, confident strokes that taper to a fine point, the kind you get from an angled brush pen.

__The setting:__ I'm going to be using the Turnip pen here (to keep all variables as consistent as possible) but you'd 
typically use a brush with a flat or angled tip for this style. 

Open Brush Size Dynamics and link size to __Tilt__ instead of Pressure, with Minimum Value near 0 so the full range 
is available. The more you lay the pen down, the wider the stroke.

__Why it looks like this:__ calligraphy's characteristic taper comes from the angle of a real brush or nib
changing how much surface touches the page, not from how hard you press. Tilt is the input that maps to that
directly. Pressure can still be layered on top for extra expressiveness, but tilt is what's actually doing the
calligraphic work here.

![Clip Studio Paint Brush Size Dynamics panel for a calligraphy brush recipe showing Tilt enabled instead of Pen pressure, with a steep curve mapping a more horizontal pen angle to a wider stroke](clip-studio-paint-calligraphy-brush-size-dynamics-tilt-settings.png#center)

{{< figure src="clip-studio-paint-calligraphy-brush-stroke-example.png" alt="Clip Studio Paint calligraphy brush stroke example showing bold, thick strokes that taper sharply to thin points" caption="Obviously, I'm not at all a calligrapher, but hopefully this illustrates how tilt can achieve something like the thick-to-thin whispiness that Japanese calligraphy is known for." align="center" >}}

## 3. Spray paint can

__The look:__ a soft, scattered cloud of texture instead of a clean line, like an actual aerosol can.

__The setting:__ switch to a brush with the __Spraying Effect__ enabled (CSP's Airbrush category has these
built in). Link __Particle Density__ to Pressure so a harder press lays down more coverage, and set __Spray
Deviation__ low so particles stay close to the center of the stroke instead of spreading into a line.

__Why it looks like this:__ this is the clearest example of pressure driving something other than size. Nothing
about the brush's width is changing at all, pressure is only controlling how dense the scatter is, which is why
it reads as texture instead of a line.

<!-- screenshot: Spraying Effect brush settings showing Particle Density linked to Pressure and Spray Deviation set low -->

<!-- screenshot/video: the actual spray paint stroke this produces, a light pass next to a hard pass showing sparse vs. dense coverage -->

## 4. Graphite pencil sketch

__The look:__ soft, buildable shading where light passes barely show up and pressing harder darkens the area,
closer to how graphite actually behaves on paper.

__The setting:__ on a pencil-textured brush, link __Opacity__ (or Density) to Pressure instead of Size, and keep
Minimum Value low on that property so light passes stay genuinely faint.

__Why it looks like this:__ this is the same lesson as the spray can from the opposite direction: pressure
driving opacity instead of size gives you value control (how dark) rather than width control (how thick), which
is what shading actually needs. A pencil brush with pressure wired to size instead would just draw fatter lines,
not darker ones.

<!-- screenshot: Dynamics panel showing Opacity (or Density) linked to Pressure instead of Size, low Minimum Value on that property -->

<!-- screenshot/video: the actual shaded patch this produces, built up from light to heavy pressure, opacity changing while width stays constant -->

## 5. Dip pen / nib line

__The look:__ a line that starts thin, swells confidently through the middle of a stroke, and snaps back to a
point at the tail, the classic ink-nib flick.

__The setting:__ link Brush Size to Pressure like normal, but this time go into the __pressure curve__ inside
that Dynamics dialog and reshape it instead of just moving Minimum Value: pull the low end down so light contact
barely registers, then let it rise steeply through the middle.

__Why it looks like this:__ Minimum Value only sets the floor and ceiling of the range. The *shape* of the curve
between those two points is a separate thing you can edit directly, and it's what decides how quickly the line
fattens as pressure increases. A steep curve gives you a fast, confident swell instead of a gradual one, which is
what a real nib's flex feels like.

![Clip Studio Paint Brush Size Dynamics pressure curve for a dip pen nib recipe, reshaped with a flat low end and a steep S-curve rise so light pressure stays thin before the line swells](clip-studio-paint-dip-pen-pressure-curve-dynamics-settings.png#center)

![Clip Studio Paint dip pen nib stroke example in blue ink showing a thin start, a confident swell through the middle of the stroke, and a tapered point at the tail](clip-studio-paint-dip-pen-nib-stroke-example.png#center)

{{< kofi-cta >}}
If these recipes save you some trial and error, buying me a coffee helps keep posts like this coming.
{{< /kofi-cta >}}

## 6. Alcohol marker flat fill

__The look:__ flat, even color that doesn't vary no matter how you press, the way a marker lays down ink
regardless of hand pressure.

__The setting:__ the most direct route: don't link Pressure to anything on this brush at all. Leave Size and
Opacity both set to their Dynamics icon showing "off." Optionally link __Velocity__ to Size instead, so a fast
drag gives a slightly different edge than a slow one, without pressure being part of the equation.

__Why it looks like this:__ this is the reminder that Dynamics inputs are opt-in, not mandatory. A brush with
nothing linked to Pressure is immune to everything covered in the Global vs. Per-Brush post, because there's no
pressure value being read in the first place. Sometimes the right setting is no setting.

<!-- screenshot: Dynamics panel showing both Size and Opacity with the Dynamics icon set to "off" for Pressure -->

<!-- screenshot/video: the actual marker strokes this produces, several passes at very different hand pressure all coming out visually identical -->

## Quick reference

| Look | Property changed | Input |
|---|---|---|
| Ballpoint pen | Size | small brush size, Minimum Value barely matters |
| Brush calligraphy | Size | Tilt |
| Spray paint | Particle Density | Pressure |
| Pencil sketch | Opacity | Pressure |
| Dip pen | Size | Pressure curve shape |
| Alcohol marker | none linked | Velocity (optional) |

Six looks, but really only three moves: which property you're driving, which input drives it, and how far you
let that input push it. Once you can name those three things for a brush you like, you can reverse-engineer
pretty much any pressure-based look you run into.
