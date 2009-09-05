def input(str)
  @client.receive_data(str)
end


Then /^I should be displayed "([^\"]*)"$/ do |str|
  @client.should be_displayed(str)
end

Then /^I should not be displayed "([^\"]*)"$/ do |str|
  @client.should_not be_displayed(str)
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