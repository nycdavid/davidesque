---
date: '2026-08-22T06:00:00-04:00'
draft: true
title: 'Clip Studio Paint Pen Pressure Settings Explained: Global vs. Per-Brush'
description: 'Clip Studio Paint has more than one pen pressure setting, and they don''t do the same thing. Here''s the full chain from your tablet to the stroke on canvas, and which setting actually fixes your problem.'
url: '/clip-studio-paint-pen-pressure/'
categories: ["Clip Studio Paint", "Art"]
---

<!-- cover image once captured: the side-by-side stroke comparison from the experiment section below -->

"Pen pressure" in Clip Studio Paint isn't one setting. It's at least three, stacked on top of each other, and
none of them show up in the same menu. That's the actual reason so many pressure problems in CSP take forever to
fix: people find *a* pressure setting, change it, and it does nothing, because the setting causing the problem
lives somewhere else entirely.

I went through this myself while digging into what [Minimum Value](/clip-studio-paint-minimum-value/) actually
does on a single brush. Fixing Minimum Value changed _that_ brush. It didn't touch the rest of my pressure setup,
because Minimum Value isn't a pressure setting on its own, it's one knob inside a much bigger system. This post
is that system, laid out end to end.

__In short:__ your mark ends up on canvas after passing through three separate pressure layers: your tablet's own
driver, Clip Studio Paint's global __Pen Pressure Settings__ (which calibrates that raw signal into CSP's
internal 0-100 value), and then that specific brush's own __Dynamics__ settings in its Sub Tool Detail panel
(which decide what the brush actually does with that value). Diagnosing a pressure problem means figuring out
which layer is actually broken.

## The chain, in order

Every stroke you draw passes through these layers before it hits the canvas:

1. __Tablet driver__: your hardware reports raw pressure to your OS. Clip Studio Paint doesn't control this at
   all. This is Wacom, Huion, or your iPad's own pressure curve, outside the app entirely.
2. __CSP's global Pen Pressure Settings__: the app takes that raw signal and remaps it into its own internal
   0-100 pressure value. This is app-wide. Every brush, every tool, every layer reads pressure through this
   calibration.
3. __That brush's Dynamics settings__: once a brush has a 0-100 pressure value in hand, its own Sub Tool Detail
   panel decides what to do with it, how much brush size changes, how much opacity varies, and where the floor
   and ceiling of that response sit (Minimum Value lives here).
4. __The stroke__: whatever comes out the other end of all three layers.

Most "my pen pressure is broken" threads are really just someone stuck diagnosing layer 3 while the actual
problem is in layer 2, or vice versa. The two settings share a name and _look_ like they should be the same
thing but they aren't.

## Where each one lives

The tablet driver setting will be different across vendors but will most likely live in the driver software. I'm
currently using the Huion Kamvas 16 Gen 3 on MacOS so mine looks like this:

{{< figure src="huion-kamvas-tablet-driver-pressure-curve.png" alt="Huion Kamvas tablet driver software showing the pen pressure curve settings used to calibrate raw pressure input on macOS" caption="I typically keep my pressure curve pretty linear at this layer." align="center" >}}

The global setting is under __CLIP STUDIO PAINT → Pen Pressure Settings__ on macOS, or __File → Pen Pressure
Settings__ on Windows. It's a Studio Mode menu item, not something tied to your current tool.

![CLIP STUDIO PAINT macOS menu bar showing Pen Pressure Settings under the CLIP STUDIO PAINT menu](clip-studio-paint-pen-pressure-settings-macos-menu.png#center)

Clip Studio's own [docs](https://support.clip-studio.com/en-us/faq/articles/20190228?utm_source=chatgpt.com) already 
cover the click-path for that dialog well, so I'm not going to re-walk it here. What their docs don't spend much time 
on is *why* recalibrating it won't fix a brush that still feels wrong, or what's actually happening underneath when you 
drag that curve toward Stronger or Lighter. That's the part worth digging into.

The per-brush setting lives somewhere completely different: select your Sub Tool, open its __Sub Tool Detail__
panel, and look at the __Dynamics__ dialog for whichever property you care about (Brush Size, Opacity,
Thickness). Inside that dialog you can link the property to __Pen pressure__, __Tilt__, __Velocity__, or
randomize it, plus fine-tune a pressure curve that's local to that one brush and has nothing to do with the
global one.

If you're on the iPad or another tablet/mobile version of CSP, one more thing to know: those platforms have a
__Simple Mode__ alongside __Studio Mode__, and Simple Mode only applies the global calibration. Per-brush
Dynamics customization doesn't exist there at all. Desktop CSP on Mac and Windows doesn't have this split, you're
always in the Studio Mode equivalent, so this only matters if you're switching devices.

## The 2026 wrinkle: velocity joined the chain

Clip Studio Paint 5.0, released in March 2026, added __Velocity__ as a full dynamics input alongside pressure
and tilt, with its own velocity graph in both the global Pen Pressure Settings and per-brush Dynamics. That
means a brush's final behavior can now be driven by how hard you press, how much you're tilting the pen, *and*
how fast you're moving it, all layered on the same property at once.

That's not a reason to panic, most brushes still ship pressure-only. But if a brush feels inconsistent in a way
that pressure alone doesn't explain, velocity is a new place to check that didn't exist before this year.

## What it actually looks like, layer by layer

Explaining the hierarchy is one thing. Seeing what each layer actually changes is more convincing, so I ran the
same brush and the same stroke through a few configurations and compared the results directly.

__Baseline.__ Same brush, same stroke, everything at default. This is the control every other capture below gets
compared against.

{{< figure src="clip-studio-paint-default-pen-pressure-stroke-baseline.png" alt="Three pen strokes in Clip Studio Paint drawn with default global pen pressure calibration and default brush dynamics, tapering naturally from light to heavy pressure" caption="Default global calibration, default brush dynamics — the control every other stroke below is compared against." align="center" >}}

__Global calibration shifted toward Stronger.__ Same brush, same stroke, brush dynamics untouched. Nothing about
the brush changed, only the global calibration, and the stroke still looks different.

{{< figure src="clip-studio-paint-global-pen-pressure-settings-stronger-curve.png" alt="Clip Studio Paint global Pen Pressure Settings dialog with the calibration curve pushed toward Stronger, boosting output above the default diagonal" caption="Global Pen Pressure Settings pushed toward Stronger, well above the default diagonal." align="center" >}}

{{< figure src="clip-studio-paint-global-pen-pressure-stronger-stroke-comparison.png" alt="Three Clip Studio Paint pen strokes compared after shifting the global pen pressure calibration toward Stronger, showing a bolder line at the same hand pressure" caption="Same brush, same hand pressure, only the global calibration changed." align="center" >}}

In this case, the line is thicker despite the same pressure given because the global calibration is biased toward stronger.
This means that it takes less pressure to get to a given "output" level.

__Per-brush pressure curve altered instead.__ Global calibration back to default, but this brush's own Dynamics
curve is changed. A similar-looking shift to the one above, caused by the opposite layer, which is exactly the
mix-up that sends people down the wrong troubleshooting path.

<!-- screenshot/video: same stroke, global calibration back to default, brush's own per-tool pressure curve
     altered instead -->

__Minimum Value raised.__ Both global and per-brush curve back to default, only this brush's Minimum Value is
raised. See [the Minimum Value post](/clip-studio-paint-minimum-value/) for what this specific setting is doing
under the hood.

{{< figure 
    src="clip-studio-paint-minimum-value-raised-stroke-comparison.png" 
    alt="Two Clip Studio Paint pen strokes compared at Minimum Value 0 versus Minimum Value 50, same brush size, showing the stroke never thins below the raised floor" 
    caption="Min Value modulating brush size at 0 vs. 50 — raising the floor keeps the stroke from ever thinning out, even at the lightest touch." 
    align="center" >}}

__Pressure driving Size vs. pressure driving Opacity.__ Same brush, same hand pressure, but Dynamics links
pressure to a different property in each. "Pressure sensitive" isn't one behavior, it depends what pressure is
wired to. The baseline stroke all the way up top is actually the Size side of this comparison already, since
that brush ships with pressure linked to Brush Size by default, that's why it tapers.

{{< figure src="clip-studio-paint-brush-dynamics-opacity-pressure-settings.png" alt="Clip Studio Paint brush Dynamics panel with Pen pressure linked to Opacity and the pressure curve left at its default straight line" caption="Dynamics panel with Pen pressure linked to Opacity, curve left at default." align="center" >}}

{{< figure src="clip-studio-paint-pressure-linked-opacity-stroke-example.png" alt="Three pen strokes in Clip Studio Paint with pressure linked to Opacity, fading from light to dark along each stroke while the line width stays constant" caption="Pressure linked to Opacity: width stays constant, only the strokes' darkness shifts with pressure." align="center" >}}

{{< kofi-cta >}}
If this saved you from chasing the wrong setting, buying me a coffee helps keep posts like this coming.
{{< /kofi-cta >}}

## Which one should you actually change

- __Every brush, every tool, every layer feels off the same way__: that's the global calibration. Fix it in Pen
  Pressure Settings before you touch anything else.
- __One specific brush feels wrong while everything else is fine__: that's local to that brush's Dynamics
  settings, not the global calibration. Check whether Pressure is even enabled as an input for the property
  you're chasing, what that brush's own pressure curve looks like, and what Minimum Value is set to.
- __A brush feels wrong only on fast strokes or only at certain tilt angles__: check whether Velocity or Tilt is
  also linked to that property. On CSP 5.0, a brush can be responding to more than pressure without it being
  obvious from the symptom alone.
- __You're on iPad/tablet CSP and nothing you do to a brush's pressure response seems to matter__: check whether
  you're in Simple Mode. It only honors the global calibration. Switch to Studio Mode to reach Dynamics.

None of these layers are broken by default. They're just independent, and CSP doesn't make that obvious from
the settings menu alone. Once you know which layer you're actually diagnosing, the fix is usually fast.
