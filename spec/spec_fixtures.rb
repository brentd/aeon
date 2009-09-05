Aeon::Player.fixture {{
  :name      => "Test Player",
  :password  => 'test_pass',
  :character => Aeon::Character.make
}}

Aeon::Character.fixture {{
  :name => "Test Character"
}}