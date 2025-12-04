---
date: '2025-12-04T09:27:39-05:00'
draft: false
title: 'What is a Controller?'
series: "kubernetes-controller"
---

The best way to think about a controller is like a thermostat in a house. A thermostat's job is to maintain a threshold 
temperature.

If the temperature of the house drops below that threshold, the thermostat detects that and sends a signal to the 
furnace to kick on. After the furnace runs for a bit and the house has warmed up to above the threshold, the thermostat
sees this and sends another signal to the furnace to turn off. It also works in the opposite direction as well, turning 
on the cooling when the home temperature goes too high.

A controller does this with resources. It can detect changes to both native K8s resources and custom resources and 
choose to do something in response to those changes.

# A simple Go program

A controller is simply a Go binary. The binary is built into an image and that image is run in a pod in your cluster.
The Go program uses the K8s watch API to observe the resource types of your choosing and then runs something called 
"reconciliation" when it detects changes to the resource(s) that it's watching.

Reconciliation, as you'll soon see, is just a Go function that receives a `Request` object and returns a `Response` 
object. The `Request` object contains the namespaced name of the resource that was changed and the idea is to, in the
body of the reconciliation function, make all the API calls necessary to reconcile the K8s state into what it should be
before returning.

Here's an example of what an empty `Reconcile` function looks like:

```go
func (r *CarReconciler) Reconcile(ctx context.Context, req ctrl.Request) (ctrl.Result, error) {
	_ = logf.FromContext(ctx)

	// change to Car resource detected
	// write the code here for what should happen when a Car resource changes
	// how can we get back to equilibrium?

	return ctrl.Result{}, nil
}
```

In the next post of the series, we'll get started on generating our own starter controller project so you can see it
in action.
