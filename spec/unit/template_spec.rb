require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Aeon::Template do
  before(:each) do
    @object = mock("Object", :class => Object)
    @player = mock("Player")
    @template = Aeon::Template.new(@player, @object)
  end
  
  it "should set an instance variable for the template using the object's name" do
    @object.stub!(:some_method).and_return("O HAI")
    @template.stub!(:file_content).and_return("<%= @object.some_method %>")
    @template.render.should == "O HAI"
  end
  
  describe "#path" do
    it "should choose a path based on the object's class" do
      @template.path.should == "#{AEON_LIB}/aeon/templates/object.erb"
    end
  end
  
  describe "#render" do
    it "should cache the contents of a template file" do
      File.should_receive(:read).once.with(@template.path).and_return("mytemplate")
      @template.render.should == "mytemplate"
      @template.render.should == "mytemplate"
    end
  end
end