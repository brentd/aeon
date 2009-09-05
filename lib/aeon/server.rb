module Aeon
  module Server
    def self.start(port)
      EventMachine.run do
        EventMachine.start_server('127.0.0.1', port, Client)
        puts "Aeon game server listening on port #{port}"
      end
    end
  end
end