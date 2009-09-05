require File.dirname(__FILE__) + '/../../spec/spec_helper'

Before do
  DataMapper.auto_migrate!
end