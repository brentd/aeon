module Aeon
  class Event
    attr_reader :instigator, :target
    
    def initialize(opts={})
      @instigator = opts[:instigator]
      @target     = opts[:target]
      propogate
    end
    
    def propogate
      @target.notify(self)
    end
  end
  
  class SpeechEvent < Event
    def initialize(opts={})
      @speech = opts[:speech]
      super
    end
    
    def message_for(recipient)
      case recipient
      when @instigator
        recipient.display("You say, '#{@speech}'")
      else
        recipient.display("#{@instigator.name} says, '#{@speech}'")
      end
    end
  end
  
end