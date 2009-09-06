module Aeon
  class Player
    include DataMapper::Resource
    include Commandable
    
    attr_accessor :client
    
    property :id,       Serial
    property :name,     String
    property :password, String
    
    has 1, :character
    
    # TODO: Encrypting passwords would probably be nice :)
    def self.authenticate(name, password)
      first(:name => name, :password => password)
    end
    
    def handle_input(input)
      invoke_command(input)
    end
    
    def animate
      character.become_animated(self)
      @animated_object = character
      look
    end

    [:north, :south, :east, :west, :up, :down].each do |direction|
      instance_eval <<-EVAL
        command :#{direction} do |input|             # command :east do |input| 
          if @animated_object.move(:#{direction})    #   if @animated_object.move(:east)
            look                                     #     look
          else                                       #   else
            display "Alas, you cannot go that way."  #     display "Alas, you cannot go that way."
          end                                        #   end
        end                                          # end
      EVAL
    end
    
    command :whoami do |input|
      display name
    end
    
    command :look do |input|
      look
    end
    
    def look
      display(@animated_object.room)
    end
    
    def display(object)
      return unless client
      object.is_a?(String) ? client.display(object) : client.display(object.render)
    end
    
  end
end