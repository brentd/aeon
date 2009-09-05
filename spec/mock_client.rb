class MockClient
  include Aeon::Client
  
  attr_reader :transcript, :input, :output

  def initialize
    @transcript = ""
    @output     = ""
    @input      = ""
    post_init
  end
  
  # Returns a string of a nicely formatted transcript. Width is 80 columns,
  # and may explode all over the place if text is wider than that.
  #
  # Here's an example of what that looks like:
  #
  #   +==============================<( TRANSCRIPT )>====================================+
  #   | What is your name, wanderer? > "TestPlayer\n"                                    
  #   | No player found by that name.                                                    
  #   |                                                                                  
  #   | What is your name, wanderer? >                                                   
  #   +==================================================================================+
  #
  def pretty_transcript
    if @transcript
      msg =  "\n+=================================<( TRANSCRIPT )>=================================+\n"
      msg << "| " << @transcript.strip.gsub(/\n/, "\n| ")
      msg << "\n+==================================================================================+\n"
    else
      msg = "Transcript was empty."
    end
  end
  
  # add received data to the transcript as input
  def receive_data(data)
    @transcript << "\n> #{data}\n"
    @input << data
    super(data)
  end
  
  # add received data to the transcript as output
  def send_data(data)
    @transcript << data
    @output << data
  end
  
  def clear!
    @output = ""
    @input  = ""
  end
  
  def ip_address
    "0.0.0.0"
  end
end

class BeDisplayed
  def initialize(expected)
    @expected = expected
  end
  
  def matches?(client)
    @client = client
    @client.output.include?(@expected)
  end
  
  def failure_message_for_should
    str = "Expected to be displayed: #{@expected.inspect}\n"
    str << @client.pretty_transcript
  end
end

def be_displayed(str)
  BeDisplayed.new(str)
end