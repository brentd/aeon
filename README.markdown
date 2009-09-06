Aeon is a MUD engine written for Ruby 1.9
-----------------------------------------

Overview / Planned Features:

* EventMachine for network connections
* Sinatra-based web interface for room/npc/item creation
* In-game ASCII maps (very simple) with line-of-sight
* Event-driven: all interactions with the game world happen as events that any 
  object can be programmed to respond to.

Aeon is in its very, very early stages of development, and in fact is pretty
much a toy at this point to explore fun design patterns and Cucumber for
integration testing.

I've attempted to make dependencies easier to manage by using
[bundler](http://github.com/wycats/bundler/), but EventMachine and RubyInline
have native extensions and are causing problems at the moment. May need to write
a rake task that'll run extconf.rb in those two projects and `make` them.

Looking for Collaborators
-------------------------

If working on a MUD for fun is something that interests you, please let me know,
and fork away. I'd love to have some folks to work with.