require 'erb'

module Aeon
  # Template objects represent a template file that converts an object into a
  # string destined for the Player's screen. Template files are evaluated with
  # ERB and rendered in the Template object's context.
  class Template
    CONTENT_CACHE = {}
    
    def initialize(player, subject)
      @player = player
      @subject = subject
      # Set a friendly instance variable for the template
      instance_variable_set("@#{object_name}", subject)
    end
    
    def render
      ERB.new(file_content, nil, "-").result(binding)
    end
    
    def file_content
      CONTENT_CACHE[path] ||= File.read(path)
    end
    
    def path
      "#{AEON_LIB}/aeon/templates/#{object_name}.erb"
    end
    
    def object_name
      @subject.class.to_s.demodulize.underscore
    end
  end
end