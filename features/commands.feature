Feature: Entering commands
  In order to interact with the game world
  As a player
  I want to input commands that control my character and give me feedback
  
  Scenario: the 'whoami' command
    Given I am a connected player
    When I enter "whoami"
    Then I should be displayed "Test Player"
        
  Scenario: abbreviating commands
    Given I am a connected player
    When I enter "whoam"
    Then I should be displayed "Test Player"
    
  Scenario: no matching command
    Given I am a connected player
    When I enter "totallymadeupcommand"
    Then I should be displayed "Huh?"
    