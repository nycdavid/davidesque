---
date: '2026-08-20T06:28:13-04:00'
draft: false
title: 'What Does “Minimum Value” Mean in Clip Studio Paint?'
description: 'Confused by Clip Studio Paint’s Minimum Value setting? Here’s what it actually controls, how 0/50/100 behave, and why pen pressure isn’t the same thing.'
url: '/clip-studio-paint-minimum-value/'
categories: ["Clip Studio Paint", "Art"]
---

If you've poked around the Sub Tool Detail panel in Clip Studio Paint, you've probably run into a setting called __Minimum Value__ tucked under __Brush Size__ (or __Thickness__, __Density__, __Opacity__, depending on which slider you're looking at). And if you're like me, you took one look at that name and assumed you already knew what it did.

I didn't. Here's the mistake I made, and what the setting is actually doing.

__In short:__ Minimum Value controls the lowest output a brush property can reach when an input such as pen pressure is at its minimum. For Brush Size, a higher Minimum Value prevents light pressure from making the line as thin. At 100, pressure no longer changes brush size.

## What I thought Minimum Value meant

I assumed __Minimum Value__ was the minimum amount of *pressure* required for the pen to leave a mark at all. Like a threshold: press lighter than this, and nothing shows up on the canvas.

That mental model made sense to me because it's roughly how a lot of real-world drawing tools behave — you need some baseline amount of force before a pencil or marker actually deposits anything. So when I saw a "Minimum" setting sitting right next to pressure-sensitive sliders, I figured it was a pressure floor: a cutoff below which the pen stops registering.

That's not what it does.

## What Minimum Value actually controls

__Minimum Value__ sets the lower bound for how much that property can be reduced by the selected input, such as pen pressure. It doesn't gate whether a stroke appears — it sets the floor of how thin, how transparent, or how sparse a stroke can get *even at the lightest input you apply*.

For Brush Size, Minimum Value is a percentage of the brush size you've configured. If your brush is set to 50 px and Minimum Value is 50, then at the minimum pressure input the brush-size floor is 25 px. A Minimum Value of 100 keeps the brush at the full configured size.

Other dynamics such as tilt and velocity can influence the same property too, so the final stroke may still be affected by more than pressure alone.

The question __Minimum Value__ answers isn't "will I make a mark?" — it's "how small can that mark be allowed to get?" And to be clear, that's not an absolute guarantee either: things like your tablet's activation threshold, or a very low opacity/density elsewhere in the brush settings, could still make an extremely light touch effectively invisible. The point isn't that Minimum Value guarantees visibility — it's that Minimum Value itself is *not* the "minimum pressure required to register" setting, which is what I originally assumed.

- __Minimum Value at 0__: the lightest input produces the thinnest/faintest possible line — potentially so faint it's barely visible.
- __Minimum Value at 100__: the input stops mattering at all for that property. Every stroke comes out at full size/opacity/density regardless of how hard you press.
- Anything in between sets a floor somewhere between those two extremes.

For brush size specifically, I think of it like compressing the lower end of the available size range — it's not that CSP is literally transforming your pressure input, just that it won't let the *output* drop below whatever floor you've set.

## My first test was misleading

Before I settled on a clean test, I ran one that gave me confusing results, and the reason why turned out to be its own useful lesson.

I was testing with Turnip Pen, and I had tilt enabled as an input affecting brush size — on top of pressure. So when I varied pressure and watched the line width change, I was actually seeing the *combined* effect of pressure and tilt, not pressure alone. Since CSP lets multiple inputs drive the same property simultaneously, my "pressure test" wasn't isolating pressure at all.

Once I disabled tilt as an input for brush size and left only pressure active, the results got a lot more consistent and readable. That's the setup I used for the real test below.

## The 0/50/100 test

With tilt out of the picture, I ran the test properly. Same brush, same pressure curve, same stroke, pressure as the only active input — I dragged the pen across the canvas at a light, consistent pressure three times, changing only __Minimum Value__ between passes.

- __0__: the stroke tapers down to almost nothing at the lightest pressure. Thin, faint, borderline invisible in spots.
- __50__: the stroke never gets thinner/fainter than about half of max, even at that same light pressure. Noticeably more consistent.
- __100__: pressure sensitivity is essentially neutralized for that property. All three passes came out looking identical in thickness, despite me applying the same light touch each time.

That's the moment it clicked for me — at no point did the line fail to appear, even at 0. The pen was never "not registering." What changed was how much room there was between the thinnest possible mark and the thickest one.

## What Should You Set Minimum Value To?

Once I understood it as a floor instead of a threshold, a few things I'd been fighting with started making sense:

- If your inking brush feels like it "disappears" on light passes, your __Minimum Value__ is probably set too low — raise it so even soft strokes stay visible.
- If you want maximum pressure sensitivity — thin, tapering, expressive lines — you want __Minimum Value__ low, closer to 0.
- If you want a brush that behaves more like a stable, consistent marker regardless of hand pressure, push __Minimum Value__ up toward 100.

It's a small setting, but it's doing a lot of quiet work in how "alive" your linework feels. Worth actually testing on your own brushes rather than assuming, the way I did.
