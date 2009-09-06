Aeon::Player.fixture {{
  :name      => "Test Player",
  :password  => 'test_pass',
  :character => Aeon::Character.make
}}

Aeon::Character.fixture {{
  :name => "Test Character"
}}

Aeon::Room.fixture {{
  :name => "Test Room",
  :description => "Just a test room"
}}