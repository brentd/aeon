Then /^I should see "(.*)"$/ do |str|
  @client.should be_displayed(str)
end

Then /^I should not see "(.*)"$/ do |str|
  @client.should_not be_displayed(str)
end

Then /^"([^\"]*)" should see "(.*)"$/ do |name, str|
  $clients[name].should be_displayed(str)
end

Then /^"([^\"]*)" should not see "(.*)"$/ do |name, str|
  $clients[name].should_not be_displayed(str)
end

Then /^I should be prompted "([^\"]*)"$/ do |str|
  @client.should be_displayed(str)
end

Then /^I should not be prompted "([^\"]*)"$/ do |str|
  @client.should_not be_displayed(str)
end

When /^I enter "([^\"]*)"$/ do |str|
  input(str)
end

def input(str)
  @client.receive_data(str)
end
