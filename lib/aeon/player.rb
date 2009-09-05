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
      instance_eval <<-INSTANCE_EVAL                          
        command :#{direction} do |input|             # command :east do |input| 
          if @animated_object.move(:#{direction})    #   if @animated_object.move(:east)
            look                                     #     look
          else                                       #   else
            display "Alas, you cannot go that way."  #     display "Alas, you cannot go that way."
          end                                        #   end
        end                                          # end
      INSTANCE_EVAL
    end
    
    command :whoami do |input|
      display name
    end
    
    def look
      display(@animated_object.room)
    end
    
    def display(object)
      case object
      when String
        client.display(str) if client
      else
        
      end
    end
    
    # def template(template_name, )
    #   
    # end
    
  end
end