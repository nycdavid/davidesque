---
date: '2025-08-18T10:05:04-04:00'
draft: true
title: How to unit test a goroutine that uses time.Ticker
---

I found the following code on the [__/r/golang__ subreddit](https://www.reddit.com/r/golang/comments/18s1jpu/how_to_unit_test_this_goroutine_select_that_uses/). 
Someone was asking how to unit test a goroutine that uses a `time.Ticker`.

```go
package goroutine_ticker

import (
	"context"
	"fmt"
	"time"
)

func PeriodicPublish(ctx context.Context, t *time.Ticker) error {
	defer t.Stop()

	for {
		select {
		case <-t.C:
			fmt.Println("data send")
		case <-ctx.Done():
			t.Stop()
			return nil
		}
	}
}
```

The original poster was complaining that this was difficult to test and that their code kept getting stuck in the
`for` loop. 

Intuitively, we can see why this would be the case as the `*time.Ticker` parameter will continue to tick
in perpetuity until it's stopped.

Although we can stop the `for` loop by calling `ctx.Done()` there's still an issue with that: we have __no control__ 
over how many times the loop will have run until `Done()` gets called. 

We could theoretically _estimate_ that count by looking at the duration used to create the ticker and try and 
call `Done()` at the exact time that `n` loops will have executed but that has high potential to be a flaky test.

## Taking control

The problem that we're faced with is that our ticker autonomously ticks because its ticking function is implemented
in the Go standard library. This is directly in conflict with the control that we need to create reliable tests.

The answer then is to:

1. Make the `PeriodicPublish` function agnostic toward the __type__ of ticker it gets and just have it accept anything
  that ticks.
2. Pass it a ticker that we can control from test.

## Enter interfaces!

If something strikes you as difficult to test because your code has to give up control to an external library,
__interfaces__ are a great first strategy.
