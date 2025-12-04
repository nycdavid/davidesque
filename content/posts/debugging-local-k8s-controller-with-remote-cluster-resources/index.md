---
date: '2025-12-02T16:34:48-05:00'
draft: true
title: 'Debugging Local K8s Controller With Remote Cluster Resources'
---

# Pre-requisites

1. Minikube (this is going to be our "remote" cluster)
   - Yes, technically, this isn't a remote cluster in the conventional sense. It _is_ running on your local machine but 
     this technique should work just as easily with a real remote cluster in cloud, as long as your K8s contexts are 
     set up correctly.

2. The `kubectx` [tool](https://github.com/ahmetb/kubectx).
   - This is just nice-to-have so you can easily select the Minikube context.

3. `kubectl`
   - You'll most likely already have this if you have prior Kubernetes experience.

4. Goland (or other breakpoint debugging-capable IDE/editor)
   - This is so we can introspect and examine all the things available to us when the reconciliation function runs.

## What is a Kubernetes controller?

> __DISCLAIMER__: I'm still learning Kubernetes. Everything below is simply my own way of understanding what
> controllers do, and I've done my best to present that understanding here in a human-readable way.
> 
> If you'd like a formal explanation of Kubernetes controllers, please refer to the [official documentation](https://kubernetes.io/docs/concepts/architecture/controller/)

To ease understanding, here are some initial concepts:

1. A resource's __definition__: YAML that indicates what a resource's state _should_ be. It's the "on-paper" specification 
   for that resource.
2. A resource's __current state__: the _actual_ state of the resource, which can fall "out-of-sync" with the definition 
   for any number of reasons during the course of normal operation.
3. The controller reconciliation: once a resource falls out-of-sync with its definition, the controller goes to work 
   to correct this.
      - Think of this like a thermostat in a house. Once the temperature falls below a threshold temperature, the 
        heating or cooling kicks on to bring the temperature back to a pre-defined level.

### An example

Let's say we have a "Car" resource definition.

```yaml
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: car.example.com
spec:
  group: example.com
  scope: Namespaced
  names:
    kind: Car
    plural: cars
    singular: car
  versions:
    - name: v1
      served: true
      storage: true
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
```

## Using `kubebuilder`

### Commands

1. `kubebuilder init --repo <repo> --domain <domain>`: creates the initial scaffolding for building
   a controller.
   - `--repo`: the Github repository where the controller lives
   - `--domain`: the domain that should be used when generating the CRDs

2. `kubebuilder create api --group <group> --version <version> --kind <Kind>`
   - `--group`
   - `--version`
   - `--kind`
