require File.dirname(__FILE__) + '/../../spec/spec_helper'

$clients = {}

Before do
  DataMapper.auto_migrate!
  DataMapper::Repository.reset_identity_maps!
  $clients = {}
end

After do
  $clients.each do |name, client|
    puts client.pretty_transcript.gsub!(/\n/, "\n    ") # indent for prettiness
  end
end