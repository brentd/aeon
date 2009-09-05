require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe DataObjects::Result do

  it "should define a standard API" do
    connection = DataObjects::Connection.new('mock://localhost')

    command = connection.create_command("SELECT * FROM example")

    result = command.execute_non_query

    # Affected Rows:
    result.should respond_to(:to_i)
    result.to_i.should == 0

    # The id of the inserted row.
    result.should respond_to(:insert_id)
    connection.close
  end

end
