require 'term/ansicolor'

class String
  include Term::ANSIColor
end

module Color
  class << self
    include Term::ANSIColor
  end
end