# Twitter - minimal implementation

A Twitter implementation from the DDD perspective, just the core logic. It is more a thought-experiment.

In this example the code is broken down into "Interactors" / Use Cases (Ops as in Operations). Commands change state of the system, Queries allow to inspect it.

Dispatching happens based on the mapping in `Ops::Mapping` module. That way you dont have to expose the class names (implementation detail) to the outside world.

`System` is a high-level abstraction that represents our application as a blackbox. The only way to interact with it is
through executing commands and issuing queries. It has internal state and a session to encapsulate the current execution context.

I have started to use a dependency injection library, but it was not done 100% throughout the codebase, so the effect is weakened by this.

Other concepts / conventions:
  - every command / query has a form object to validate the incomming params
  - commands use pub/sub functions of `wisper`, this allows to shape custom protocol to communicate the result
  to the interested actors in a more decoupled way
  - queries are more direct and return the result directly or raise on invalid queries
  - authorization needs are encapsulated in simple PORO policy objects (like pundit)
  - DB layer / Entities was not separated (yet)
  - migrator has all the DB schema inline (quick prototyping)
  - tests use an in-memory SQLITE db
  - most tests should be written by using the `system` metaphor (see test/flows/*.rb) for details

Current test time:

```
Test results:
  Finished in 0.11073s
  22 tests, 43 assertions, 0 failures, 0 errors, 0 skips
```

# Gems used:
  - Little Boxes: https://github.com/manuelmorales/little-boxes - a small dependency injection library
  - Scrivener: https://github.com/soveran/scrivener - Validation frontend for models
  - Wisper: https://github.com/krisleech/wisper - A micro library providing Ruby objects with Publish-Subscribe capabilities
  - Sequel: http://sequel.jeremyevans.net/ - The Database Toolkit for Ruby
  - ActiveSupport: for lazy loading
