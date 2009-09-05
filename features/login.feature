Feature: Logging In
  In order to securely login to Aeon
  As a player
  I want to input my player's name and password when I connect

  Scenario: Connecting to an existing player
    Given an existing player
    When I connect
    Then I should be prompted "What is your name, wanderer? >"
    When I enter my player name
    Then I should be prompted "OK, give me a password for Test Player >"
    When I enter my password
    Then I should be displayed "Welcome to Aeon"
    
  Scenario: A player that doesn't exist
    Given an existing player
    When I connect
     And I enter a nonexistant player name
    Then I should be displayed "No player found by that name."
     And I should be prompted "What is your name, wanderer?"
    
  Scenario: Incorrect password
    Given an existing player
    When I connect
     And I enter my player name
     And I enter an incorrect password
    Then I should be displayed "Password incorrect."
     And I should be prompted "What is your name, wanderer?"
    