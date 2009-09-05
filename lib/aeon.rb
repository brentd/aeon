unless RUBY_VERSION =~ /1\.9/
  raise LoadError, "Aeon requires Ruby 1.9!"
end

AEON_ENV ||= :development
AEON_LIB = File.expand_path(File.dirname(__FILE__))

unless $LOAD_PATH.include?(AEON_LIB)
  $LOAD_PATH.unshift(AEON_LIB)
end

# Required libs.

require File.join(File.dirname(__FILE__), "../vendor/gems/environment")

require 'eventmachine'
require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
require 'dm-ar-finders'
require 'active_support/inflector'
require 'change_class'

# Setup the database.
DataMapper.setup(:default, :adapter => 'sqlite3', :database => 'db/db.sqlite3')

require 'aeon/extensions/object'
require 'aeon/extensions/object_space'

require 'aeon/server'
require 'aeon/reloader'

# These files will be automatically reloaded when modified in development mode.
Aeon::Reloader.observe do
  require 'aeon/world'
  require 'aeon/input_state_machine'
  require 'aeon/client'
  require 'aeon/connector'
  require 'aeon/commandable'
  require 'aeon/player'
  require 'aeon/character'
  require 'aeon/room'
  require 'aeon/template'
end