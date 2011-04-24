Aeon is a MUD engine written for Ruby 1.9
=========================================

Overview / Planned Features:

* EventMachine for network connections
* Sinatra-based web interface for room/npc/item creation
* In-game ASCII maps (very simple) with line-of-sight
* Event-driven: all interactions with the game world happen as events that any 
  object can be programmed to respond to.

Aeon is in its very, very early stages of development, and in fact is pretty
much a toy at this point to explore fun design patterns and Cucumber for
integration testing.

Installation
------------

Gem dependencies are included via [bundler](http://github.com/carlhuda/bundler/).
If you don't have bundler installed already, first install it:

    gem install bundler

Gem dependencies are defined in the `Gemfile`. 
From the root of the project you need to run:

    bundle

Running the Specs
-----------------

Run the whole suite with `rake`.

For running individual specs, you should use the bundled spec executable:

    bundle exec rspec spec/some_spec.rb
    
NOTE: some specs are failing after an update to DataMapper.

Looking for Collaborators
-------------------------

If working on a MUD for fun is something that interests you, please let me know,
and fork away. I'd love to have some folks to work with.
