# encoding: utf-8

require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))
require 'data_objects/spec/connection_spec'

describe DataObjects::Sqlite3::Connection do

  before :all do
    @driver = CONFIG.scheme
    @user   = CONFIG.user
    @password = CONFIG.pass
    @host   = CONFIG.host
    @port   = CONFIG.port
    @database = CONFIG.database
  end

  it_should_behave_like 'a Connection'
end
