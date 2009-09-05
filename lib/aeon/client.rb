require 'socket'

module Aeon
  module Client
    attr_reader :player
    
    # Called when the client connects
    def post_init
      @connector = Aeon::Connector.new(self)
    end
    
    # Called when we receive data from the client
    def receive_data(data)
      # puts "From #{(@player || @connector).inspect} #{ip_address}:"
      # puts "> " + data.inspect
      
      benchmark do
        if @player
          @player.handle_input(data.strip)
        else
          @connector.handle_input(data.strip)
        end
      end
    rescue Exception => e
      raise e if AEON_ENV == :test
    end
    
    # Called when the client disconnects
    def unbind
      @player.logout if @player
      @player = nil
      @connector = nil
    end
    
    def login(player)
      self.player = player
      player.client = self
      player.animate
    end
    
    # Assigns a player to this client - input from the client will be sent to
    # this object.
    def player=(player)
      @player = player
    end
    
    def prompt(str)
      send_data "\n#{str}"
    end
  
    def display(str)
      send_data "\n#{str}\n"
    end
    
    def ip_address
      Socket.unpack_sockaddr_in(get_peername)[1]
    end
    
    private
    
    def benchmark
      start_time = Time.now
      yield
      seconds = Time.now - start_time
      ms = seconds * 1000
      reqs_per_second = 1 / seconds
      # puts "Time: %.0fms (%.0f req/s)\n\n" % [ms, reqs_per_second]
    end
    
  end
end