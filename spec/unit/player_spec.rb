require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Aeon::Player do
  before(:each) do
    @player = Aeon::Player.new
  end
  
  it "should animate its character" do
    character = mock("Character")
    character.should_receive(:become_animated).with(@player)
    
    @player.stub!(:character).and_return(character)
    @player.should_receive(:look)
    @player.animate
  end
end