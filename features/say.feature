Feature: The 'say' command
  In order to speak to other characters and NPC's
  As a player
  I want to command my character to say things
  
  Scenario: Feedback when my character speaks
    Given I am a connected player
    When I enter "say hello"
    Then I should see "You say, 'hello'"
    
  Scenario: Speaking in a room with another character
    Given I am a player named "Ethrin" in room "r1"
    And a player named "Halv" in room "r1"
    When I enter "say hello"
    Then I should see "You say, 'hello'"
    And "Halv" should see "Ethrin says, 'hello'"
    