Feature: Moving around the world
  In order to explore the world
  As a player
  I want enter commands that allow me to move between rooms

  Scenario: Connecting with a new character
    Given a room
    And I am a connected player
    Then I should be displayed "Room 0,0"
    
  # 0,1 – 1,1
  #  |     |
  # 0,0 – 1,0
  Scenario: Moving east, north, west, south
    Given a 2x2 area of rooms
    And I am a connected player
    Then I should be displayed "Room 0,0"
    When I enter "e"
    Then I should be displayed "Room 1,0"
    When I enter "n"
    Then I should be displayed "Room 1,1"
    When I enter "w"
    Then I should be displayed "Room 0,1"
    When I enter "s"
    Then I should be displayed "Room 0,0"
    
  Scenario: Trying to move in a direction where there isn't a room
    Given a room
    And I am a connected player
    Then I should be displayed "Room 0,0"
    When I enter "west"
    Then I should be displayed "Alas, you cannot go that way"

  Scenario: Moving up and down
    Given "r2" is up from "r1"
    And I am a connected player
    Then I should be displayed "r1"
    When I enter "u"
    Then I should be displayed "r2"
    When I enter "d"
    Then I should be displayed "r1"
    
  Scenario: Seeing other characters
    Given "r1" is west of "r2"
    And I am a connected player in room "r1"
    And a connected player named "Ethrin" in room "r2"
    Then I should not be displayed "Ethrin"
    When I enter "east"
    Then I should be displayed "Ethrin"
    
  Scenario: Showing one exit
    Given "r1" is west of "r2"
    And I am a connected player in room "r1"
    Then I should be displayed "Exits: [e]"
    
  Scenario: Showing multiple exits
    Given "r2" is west of "r1"
    And "r3" is east of "r1"
    And "r4" is up from "r1"
    And I am a connected player in room "r1"
    Then I should be displayed "Exits: [e, w, u]"