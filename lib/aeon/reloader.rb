module Aeon
  module Reloader
    LOADED_FILES   = {} # observed files and their last modification time
    LOADED_CLASSES = {} # observed files and the classes they define
    
    class << self  
      # Define a list of files to be observed and reloaded when changed. 
      #   
      #   Aeon::Reloader.observe do
      #     require 'aeon/world'
      #     require 'aeon/player'
      #   end
      #
      def observe(&block)
        instance_eval(&block)
        
        if AEON_ENV == :development
          TimedExecutor.every(2) { reload_modified_files! }
        end
      end
      
      # Override require for our observing purposes.
      #
      def require(path)
        full_path = if path[0] == '/'
          path
        else
          File.expand_path(File.join(AEON_LIB, "#{path}.rb"))
        end
        observe_file(full_path) { Kernel.require(path) }
      end
      
      def observe_file(full_path)
        LOADED_FILES[full_path] = File.mtime(full_path)
        klasses = ObjectSpace.classes.dup
        yield
        LOADED_CLASSES[full_path] = ObjectSpace.classes - klasses
      end
      
      # Checks all observed files and reloads each if they've been modified
      # since we last loaded them.
      #
      def reload_modified_files!
        LOADED_FILES.each do |path, last_modified|
          reload_file(path) if File.mtime(path) > last_modified
        end
      end
      
      # Loads the specified file and sets it up to be observed for changes.
      #
      def reload_file(path)
        # puts "Reloading: #{path}"
        old_classes = LOADED_CLASSES[path]
        old_classes.each {|const| remove_constant(const)}
        observe_file(path) { Kernel.load(path) }
        reset_object_classes(old_classes)
      rescue LoadError, SyntaxError => e
        # puts "Error loading #{path}: #{e}"
      end
            
      def remove_constant(const)
        parts = const.to_s.split("::")
        base = parts.size == 1 ? Object : Object.full_const_get(parts[0..-2].join("::"))
        object = parts[-1].to_sym
        base.send(:remove_const, object)
      end
      
      # Resets instances of the specified classes using the #class= setter 
      # provided by the change_class gem. This forces objects into referencing a 
      # newly loaded Class constant, thus they'll begin using its updated code.
      def reset_object_classes(klasses)
        klasses.each do |klass|
          new_class = Object.full_const_get(klass.to_s)
          ObjectSpace.each_object(klass) do |obj| 
            obj.class = new_class
          end
        end
      end
      
    end # class << self
    
    # Starts a new thread that repeats the passed block at the specified interval.
    #
    module TimedExecutor
      def self.every(seconds, &block)
        Thread.abort_on_exception = true
        Thread.new do
          loop do
            sleep( seconds )
            block.call
          end
          Thread.exit
        end
      end
    end # module TimedExecutor
    
  end # module Reloader
end # module Aeon