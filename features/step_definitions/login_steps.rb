Given /^an existing player$/ do
  @player = Aeon::Player.gen
end

Given /^I am a connected player$/ do
  @player = Aeon::Player.gen
  @client = MockClient.new
  @client.login(@player)
end

Given /^I am a connected player in room "([^\"]*)"$/ do |room|
  @player = Aeon::Player.gen
  @player.character.update_attributes(:room => Aeon::Room.find_by_name(room))
  @client = MockClient.new
  @client.login(@player)  
end 

Given /^a connected player named "([^\"]*)" in room "([^\"]*)"$/ do |name, room|
  room = Aeon::Room.find_by_name(room)
  player = Aeon::Player.gen(
    :name => name, 
    :character => Aeon::Character.gen(
      :name => name, 
      :room => room
    ))
end

Given /^my character is in room "([^\"]*)"$/ do |room|
  @player.character.room = Aeon::Room.find_by_name(room)
  @player.character.save
end

When /^I connect$/ do
  @client = MockClient.new
end

When /^I enter my player name$/ do
  input(@player.name)
end

When /^I enter my password$/ do
  input(@player.password)
end

When /^I enter a nonexistant player name$/ do
  input('nonexistant_player')
end

When /^I enter an incorrect password$/ do
  input('incorrect_password')
end