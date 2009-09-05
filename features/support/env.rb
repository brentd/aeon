require File.dirname(__FILE__) + '/../../spec/spec_helper'

Before do
  DataMapper.auto_migrate!
end

After do
  puts @client.pretty_transcript.gsub!(/\n/, "\n    ") if @client
end