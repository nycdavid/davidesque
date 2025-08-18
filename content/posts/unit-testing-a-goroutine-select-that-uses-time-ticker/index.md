---
date: '2025-08-18T10:05:04-04:00'
draft: true
title: How to unit test a goroutine that uses time.Ticker
---

Let's say we have the following code:

```go
package main

import (
  "context"
	"time"
)

type (
  Publisher struct {}
)

func (p *Publisher) PeriodicPublish(ctx context.Context, t *time.Ticker) error {
	defer t.Stop()
	
  for {
		select {
		case timer := <-t.C:
			// send data to service
    case <-ctx.Done():
			t.Stop()
			return nil
    }
  }
}
```
