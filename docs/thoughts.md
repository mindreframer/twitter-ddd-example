Pjax Alternatives:
  http://barbajs.org/demos.html
  http://intercoolerjs.org/
  https://unpoly.com/up.syntax
  https://speakerdeck.com/ninthspace/ajax-pjax-and-beyond
  http://roca-style.org/libraries.html


Clean Architecture
  - [Better Software Design with Clean Architecture (fullstackmark.com)](https://news.ycombinator.com/item?id=14686726)

  daigoba66 7 hours ago [-]
    I've come to the exact same conclusion after spending time with these same types of systems.
    Practically speaking, I find that abstracting a system into a set of commands and a set of queries (i.e. CQRS) is often the "right" solution. Each command/query encapsulates an individual use-case, and all of the business rules and database access required.



  dayjah 5 hours ago [-]
    I had been quite skeptical of Clean Architecture when I first came across it. I don't find Uncle Bob's post on it particularly insightful; for me it's not vocational enough.
    Then a few years ago I had to maintain a software stack written by contractors from Pivotal (https://pivotal.io/) in a Clean Architecture style - it was truly a revelation for me; akin to that "aha" moment of fully grokking homoiconicity in LISPs.
    Now, up until this point, all code I'd encountered at Twitch heavily reflected the domain of the problem it was solving and the technology in which it was written. That is, if you were looking at a certain piece of architecture you had to really fully understand not only exactly the intent of that code base but also the details of the framework in which it was written. As codebases increased in number and size, it became much harder to scale as an engineer. Jumping from a Rails monolith, to a highly concurrent Golang HTTP CRUD-API, to a highly asynchronous Twisted-Python request routing system (broadly the main three backend techs) had a very large cognitive load. The eng org cleaved along these lines and maintaining velocity in that world was very hard; attempts to introduce new tech or join chunks of the org took on a "religious" tone.
    So initially coming across this clean architecture stack felt very similar to that. It had a lot of "weird new things" in it, but once I understood that much of it was routing (tagging inbound requests in a manner that a deeper layer could understand the intent of the request and pass it to the correct interactor, which would then work on the appropriate entities) it suddenly became incredibly easy to hop around the code base and update the important aspects of it.
    I asked the authors who had been contracted to build this system where they got their inspiration and they cited many lunchtime discussions and pair programming sessions influenced heavily by Uncle Bob's clean architecture.
    I would have really enjoyed seeing more systems built like this because, to the maintenance programmer, it was very clear where things had to go. However only encountering one Clean Architected system didn't really give me a solid idea of how well it would scale across various domains.


Business Logic:
  http://onfido.ghost.io/commands-and-use-cases/
  https://www.jasonroelofs.com/2013/02/11/raidit-final-thoughts
  http://hawkins.io/2014/01/writing_use_cases/
  http://hawkins.io/2014/01/entities/
  http://hawkins.io/2014/01/form_objects_with_virtus/
  http://www.strauss.io/blog/2015-alternative-interactor-implementation-in-lotus.html

  http://solnic.eu/2015/12/28/invalid-object-is-an-anti-pattern.html
  https://bryanrite.com/simplifying-complex-rails-apps-with-operations/
  http://viralfoundry.com/journal/beyond-mvc-with-rails
  http://laithazer.com/blog/2017/04/16/rails-interactors-skinny-controllers-skinny-models/
  https://www.reddit.com/r/ruby/comments/55n2se/good_command_object_pattern_implementations/?st=j4h0bu0o&sh=b78a06e4
  https://beberlei.de/2012/08/13/oop_business_applications_entity_boundary_interactor.html
  http://www.plugingeek.com/categories/interactions-ruby

Gems:
  https://github.com/jasonroelofs/raidit/tree/master/app/interactors
  https://github.com/pyzlnar/aye_commander
  https://github.com/collectiveidea/interactor
  https://github.com/cypriss/mutations
  https://github.com/adomokos/light-service
  https://github.com/orgsync/active_interaction
  http://trailblazer.to/gems/operation/2.0/
  https://github.com/onfido/tzu
  https://github.com/onfido/tradesman
  https://github.com/gilbert/solid_use_case

  https://github.com/ahawkins/chassis
  http://www.plugingeek.com/repos/makandra/active_type


Validations:
  https://blog.ragnarson.com/2016/10/26/validation-outside-activemodel.html

Critique
  https://medium.com/jetruby/parsing-data-from-socials-interactor-gem-fd5f15c2f08f


General list:
  https://www.quora.com/What-are-the-most-useful-gems-to-use-in-Rails
