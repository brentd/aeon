AEON_ENV = :test
require File.dirname(__FILE__) + '/../lib/aeon'

# Override the default DataMapper connection to be in-memory sqlite
DataMapper.setup(:default, "sqlite3::memory:")

require 'spec'
require 'dm-sweatshop'

require File.dirname(__FILE__) + '/spec_fixtures'
require File.dirname(__FILE__) + '/mock_client'

# DataMapper.logger.set_log(STDOUT, :debug)

Spec::Runner.configure do |config|
  config.before(:each) do
    DataMapper.auto_migrate!
    DataMapper::Repository.reset_identity_maps!
  end
end

# Silence or capture STDOUT
def capture_stdout
  output = StringIO.new
  $stdout = output
  yield
  $stdout = STDOUT
  output
end