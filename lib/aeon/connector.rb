module Aeon
  class Connector
    include InputStateMachine
    
    def initialize(client)
      @client = client
      transition_to :enter_name
    end

    state :enter_name do
      on_enter { @client.prompt "What is your name, wanderer? > " }

      handle_input do |name|
        if Aeon::Player.first(:name => name)
          @player_name = name
          transition_to :enter_password
        else
          @client.display("No player found by that name.")
          transition_to :enter_name
        end
      end
    end

    state :enter_password do
      on_enter { @client.prompt "OK, give me a password for #{@player_name} > " }

      handle_input do |password|
        if @player = Aeon::Player.authenticate(@player_name, password)
          transition_to :logged_in
        else
          @client.display("Password incorrect.")
          transition_to :enter_name
        end
      end
    end

    state :logged_in do
      on_enter do 
        @client.display "Welcome to Aeon, #{@player.name}."
        @client.login(@player)
      end
    end
  end
end