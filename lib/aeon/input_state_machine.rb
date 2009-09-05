module Aeon
  module InputStateMachine
    def self.included(base)
      base.send(:extend, ClassMethods)
      base.send(:include, InstanceMethods)
    end
    
    module ClassMethods
      def state(state_name, &block)
        @@states ||= []
        @@states << state_name
        block.call
      end

      def on_enter(&block)
        define_method("#{@@states.last.to_s}_on_enter", block)
      end

      def handle_input(&block)
        define_method("#{@@states.last.to_s}_handle_input", block)
      end
    end

    module InstanceMethods
      def transition_to(state_name)
        @current_state = state_name
        send("#{@current_state}_on_enter")
      end

      def handle_input(input)
        send("#{@current_state}_handle_input", input)
      end
    end
  end
end