---
date: '2025-08-18T10:05:04-04:00'
draft: true
title: How to unit test a function that uses time.Ticker
---

I found the following code on the [__/r/golang__ subreddit](https://www.reddit.com/r/golang/comments/18s1jpu/how_to_unit_test_this_goroutine_select_that_uses/). 
Someone was asking how to unit test a function that uses a `time.Ticker`.

```go
package ticker

import (
	"fmt"
	"time"
)

type (
	Printer struct {
		Iteration int
	}
)

func (p *Printer) Start() {
	t := time.NewTicker(10 * time.Second) // fixed real interval
	defer t.Stop()

	for {
		select {
		case <-t.C:
			// Directly tied to wall clock, hard to control in tests
			fmt.Println("tick at", time.Now())
			p.Iteration++
		}
	}
}
```

with a unit test that looks like:

```go
package goroutine_ticker_test

import (
	"testing"

	"github.com/nycdavid/scratch/golang/goroutine-time-ticker-tests/goroutine-ticker"
	_assert "github.com/stretchr/testify/assert"
)

func Test_PeriodicPublish(t *testing.T) {
	assert := _assert.New(t)

	printer := &goroutine_ticker.Printer{}
	printer.Start()
	
  // how?

	assert.Equal(printer.Iteration, 5)
}
```

The original poster was complaining that this was difficult to test and that their code kept getting stuck in the
`for` loop. 

Intuitively, we can see why this would be the case as the `*time.Ticker` will continue to tick in perpetuity until 
it's stopped.

## Taking control

The problem is that our ticker autonomously ticks, since its ticking function is implemented
in the Go standard library. This is directly in conflict with the control that we need to create reliable tests.

The answer then is to:

1. Make the function agnostic toward the __type__ of ticker it gets and just have it accept anything that ticks.
2. Pass it a ticker that we can control from test.

## Enter interfaces!

If something strikes you as difficult to test because your code has to call out to an external library,
__interfaces__ are a great first strategy.

If we can get the `select` statement above to listen on a channel that "ticks" from within our unit test, then we can 
ensure that the code in the body of the `Start` method executes a deterministic number of times while unit testing.

To do this, we have to change the `Printer` struct to store an interface that implements the same methods as a real 
`time.Ticker`, namely a `C()` method that returns a channel and a `Stop()` method. That way, in test, we can use a fake ticker to allow for 
repeatable tests but a real one in production.

Once we change the struct to store an interface type that a Ticker implements, we can have the `select` in the `Start` 
function use that instead of creating a new one.

```go
type (
  Ticker interface {
    C() <-chan time.Time
    Stop()
  }
)
func (p *Printer) Start(ctx context.Context, done chan struct{}) {
	defer p.Clock.Stop()

	for {
		select {
		case <-p.Clock.C():
			// Directly tied to wall clock, hard to control in tests
			fmt.Println("tick at", time.Now())
			p.Iteration++
		case <-ctx.Done():
			fmt.Println("exiting...")
			close(done)
			return
		}
	}
}
```

## The test

Now our test can be refactored like this:

```go
type (
  mockClock struct {
    c chan time.Time
  }
	
  Printer struct {
    Iteration int
    Clock     Ticker
  }
)

func (m *mockClock) C() <-chan time.Time {
  return m.c
}

func (m *mockClock) Stop() {}

func Test_PeriodicPublish(t *testing.T) {
	assert := _assert.New(t)

	timeChan := make(chan time.Time)

	printer := &ticker.Printer{
		Clock: &mockClock{
			c: timeChan,
		},
	}

	ctx, cancel := context.WithCancel(context.Background())
	done := make(chan struct{})
	go printer.Start(ctx, done)

	timeChan <- time.Now()
	timeChan <- time.Now()
	timeChan <- time.Now()
	timeChan <- time.Now()
	timeChan <- time.Now()

	cancel()
	<-done

	assert.Equal(5, printer.Iteration)
}
```

Notice that we have a `mockClock` struct in our test, which is our stand-in for a real `Ticker`. 

The `mockClock` struct has the 2 methods it needs to implement our `Ticker` interface, and we'll instantiate a `mockClock` 
with a channel that we hold a reference to in test so that we can send on the channel and get the code in `Start` to 
execute how we want!

## Code examples

A full, working code example can be found [here](https://github.com/nycdavid/davidesque-code-examples/tree/main/how-to-unit-test-a-function-that-uses-ticker)
and a before and after refactoring diff can be seen [here](https://github.com/nycdavid/davidesque-code-examples/compare/1c1ef862f10731b33108a6abc5c285342593ead0..507e4a395b82622a49763bb844973ac0cbbbd392)

Thanks for reading!
