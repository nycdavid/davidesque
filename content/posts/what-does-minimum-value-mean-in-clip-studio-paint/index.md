---
date: '2026-08-20T06:28:13-04:00'
draft: true
title: 'What Does “Minimum Value” Mean in Clip Studio Paint?'
categories: ["Clip Studio Paint"]
---

If you've poked around the Sub Tool Detail panel in Clip Studio Paint, you've probably run into a setting called __Minimum Value__ tucked under __Brush Size__ (or __Thickness__, __Density__, __Opacity__, depending on which slider you're looking at). And if you're like me, you took one look at that name and assumed you already knew what it did.

I didn't. Here's the mistake I made, and what the setting is actually doing.

## What I thought Minimum Value meant

I assumed __Minimum Value__ was the minimum amount of *pressure* required for the pen to leave a mark at all. Like a threshold: press lighter than this, and nothing shows up on the canvas.

That mental model made sense to me because it's roughly how a lot of real-world drawing tools behave — you need some baseline amount of force before a pencil or marker actually deposits anything. So when I saw a "Minimum" setting sitting right next to pressure-sensitive sliders, I figured it was a pressure floor: a cutoff below which the pen stops registering.

That's not what it does.

## What Minimum Value actually controls

__Minimum Value__ sets the *smallest possible output* for that property, expressed as a percentage of the maximum. It doesn't gate whether a stroke appears — it sets the floor of how thin, how transparent, or how sparse a stroke can get *even at the lightest pressure you apply*.

In other words: your pen will still make a mark at the softest touch you're capable of. The question __Minimum Value__ answers isn't "will I make a mark?" — it's "how small can that mark be allowed to get?"

- __Minimum Value at 0__: the lightest pressure produces the thinnest/faintest possible line — potentially so faint it's barely visible.
- __Minimum Value at 100__: pressure stops mattering at all for that property. Every stroke comes out at full size/opacity/density regardless of how hard you press.
- Anything in between sets a floor somewhere between those two extremes.

So it's not a pressure *threshold*, it's a pressure *range compressor*. It squeezes the bottom end of your pressure curve up (or down) to wherever you set it.

## The 0/50/100 test

I didn't want to just take this on faith, so I ran a quick test. Same brush, same pressure curve, same stroke — I just dragged the pen across the canvas at a light, consistent pressure three times, changing only __Minimum Value__ between passes.

- __0__: the stroke tapers down to almost nothing at the lightest pressure. Thin, faint, borderline invisible in spots.
- __50__: the stroke never gets thinner/fainter than about half of max, even at that same light pressure. Noticeably more consistent.
- __100__: pressure sensitivity is essentially neutralized for that property. All three passes came out looking identical in thickness, despite me applying the same light touch each time.

That's the moment it clicked for me — at no point did the line fail to appear, even at 0. The pen was never "not registering." What changed was how much room there was between the thinnest possible mark and the thickest one.

## Why this actually matters for your brushes

Once I understood it as a floor instead of a threshold, a few things I'd been fighting with started making sense:

- If your inking brush feels like it "disappears" on light passes, your __Minimum Value__ is probably set too low — raise it so even soft strokes stay visible.
- If you want maximum pressure sensitivity — thin, tapering, expressive lines — you want __Minimum Value__ low, closer to 0.
- If you want a brush that behaves more like a stable, consistent marker regardless of hand pressure, push __Minimum Value__ up toward 100.

It's a small setting, but it's doing a lot of quiet work in how "alive" your linework feels. Worth actually testing on your own brushes rather than assuming, the way I did.
