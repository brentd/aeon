require File.dirname(__FILE__) + '/../spec_helper'

describe Aeon::Client do
  
  before(:each) do
    @client = MockClient.new
  end
  
  it "should create an instance of Aeon::Connector" do
    Aeon::Connector.should_receive(:new)
    @client.post_init
  end
  
  it "should send input to the Connector until a Player logs in" do
    connector = mock('Connector')
    Aeon::Connector.stub!(:new).and_return(connector)
    @client.post_init
    
    connector.should_receive(:handle_input).with('foo')
    capture_stdout { @client.receive_data('foo') }
  end
  
  it "should send input to the Player if set" do
    player = mock('Player')    
    @client.player = player
    
    player.should_receive(:handle_input).with('foo')
    capture_stdout { @client.receive_data('foo') }
  end
  
  it "should tell the Player to animate after login" do
    player = mock('Player')
    player.should_receive(:client=).with(@client)
    player.should_receive(:animate)
    @client.login(player)
  end
  
end