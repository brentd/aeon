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
        entered_command = input.match(/^\w+/)[0]

        if command = self.class.commands.grep(/^#{entered_command}/).first
          args = input.gsub(/^#{command}(\s+)?/, '')
          send("cmd_#{command}", args)
        else
          display("Huh?")
        end
      end
    end
  end
end