module Aeon
  module Commandable
    def self.included(base)
      base.send(:extend, ClassMethods)
      base.send(:include, InstanceMethods)
    end
    
    module ClassMethods
      def commands
        @commands ||= []
      end
      
      def command(name, &block)
        commands << name.to_s
        define_method("cmd_#{name}", block)
      end
    end
    
    module InstanceMethods
      def invoke_command(input)
        results = self.class.commands.grep(/^#{input}/)
        if command = results.first
          send("cmd_#{command}", input)
        else
          display("Huh?")
        end
      end
    end
  end
end