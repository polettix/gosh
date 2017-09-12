# GOSH - Gamification Of Shared Housekeeping

The basics of GOSH are to record activities performed by different actors
in time, allowing to extract statistics and implement the real
gamification on top of the raw collected data.

The basic concepts are:

* Actor: an entity that executes Activities and that needs those
  executions to be tracked. It's usually a person, but might also be a
  group of Actors (there is also the concept of "Actor belonging to
  another Actor", in which the latter is a group).
  The basic data tracked for an Actor are:
    * `displayname`: the name that should be used to refer to the Actor.
      There is no enforcement of uniqueness for this (each Actor gets a
      unique `id` anyway)
    * `id`: unique identifier for the Actor

* Activity: an action/operation that can be done. The more atomic it is,
  the better, within limits so that keeping up with updates is still a
  reasonable activity. It is important to stress that this is only the
  *idea* of the activity, not a recording of something that has been
  performed at a certain point in time. The basic data tracked for an
  Activity are: 
  
    * `description`: a (possibly precise) description of the Activity,
      e.g. `load dishes in the dishwasher` or `run a washing machine
      cycle`

    * `id`: unique identifier for the Activity
    
    * `name`: the name of the activity, which should be a *summary* of the
      description

* Catalog: a set of Activities that can be tracked for an Actor. In case
  the Actor is a group, every member (recursively) can access the Activity
  for its tracking. The following data are tracked for each item in the
  Catalog:
    * `activity`: the activity (identifier)

    * `actor`: the actor for which we want to create the association

    * `amount`: how many *points* are granted to the Actor for performing
      the Activity

    * `date_end`: the final date of validity of an item in the catalog

    * `date_start`: the starting date of validity of an item in the
      catalog

    * `id`: unique identifier for the catalog item. 

* Register: a ledger where every execution of an Activity by an Actor is
  recorded. The following data are tracked for each record in the
  Register:

  * `activity`: the activity that was performed

  * `actor`: who performed the Activity

  * `amount`: how much points were granted for performing the Activity

  * `id`: unique identifier associated to the record

  * `itsdate`: the date of execution of the activity

A basic interaction model is the following:

* *Setup*

    * at the beginning, Actors are created and grouped. E.g. in housekeeping
      there would be an Actor for each person participating in the game (e.g.
      *Alice* and *Bob*), plus one Actor grouping them all (e.g. *Smiths*)

    * Actors agree on the Activities that can be tracked, e.g. "running a
    washing cycle in the washing machine", "put wet robe on the dryer",
    etc., and build the list of Activities

    * Actors then build the Catalog, assigning an amount of points to each
    activity for the group Actor (*Smiths* in our example), so that each
    participant can access the same data. The value of an Activity is
    recorded separately so that it can evolve in time as Actors tune up
    their own model.

* Runtime: each time an Activity is performed by an Actor, a record is
  added in the Register, with a timestamp and the amount of points granted
  (which should generally be taken from the Catalog).


