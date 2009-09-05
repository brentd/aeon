require File.dirname(__FILE__) + '/../spec_helper'
require 'tempfile'

describe Aeon::Reloader do
  describe ".require" do
    it "should store the mtime of a required file" do
      File.should_receive(:mtime).with(AEON_LIB + '/myfile.rb')
      Kernel.should_receive(:require).with('myfile')
      Aeon::Reloader.require('myfile')
    end
  end
  
  describe ".reload_file" do
    before(:each) do
      @tempfile = Tempfile.new(['class_to_reload', '.rb'])
      @tempfile << "class ClassToReload; end"
      @tempfile.flush
      Aeon::Reloader.require(@tempfile.path)
    end
    
    after(:each) do
      Object.send(:remove_const, :ClassToReload) if Object.const_defined?(:ClassToReload)
      $LOADED_FEATURES.delete(@tempfile.path)
      @tempfile.close
    end
    
    it "should reset the class of any instanced defined by a file's class" do
      klass_id = ClassToReload.object_id
      instance = ClassToReload.new
      Aeon::Reloader.reload_file(@tempfile.path)
      instance.class.object_id.should_not == klass_id
    end
    
    it "should actually load new code for reset instances" do
      instance = ClassToReload.new
      lambda { instance.hello }.should raise_error(NoMethodError)

      @tempfile.rewind
      @tempfile << "class ClassToReload; def hello; end; end"
      @tempfile.flush
      
      Aeon::Reloader.reload_file(@tempfile.path)
      lambda { instance.hello }.should_not raise_error
    end
    
    it "should fail gracefully if a syntax error occurs" do
      @tempfile.rewind
      @tempfile << "class NeverEndingClass"
      @tempfile.flush
      lambda { Aeon::Reloader.reload_file(@tempfile.path) }.should_not raise_error
    end
  end
  
  describe ".reload_modified_files!" do
    before(:each) do
      File.stub!(:mtime).and_return(Time.utc(1970))
    end
    
    it "should reload a file if modified" do
      Kernel.stub!(:require)
      Aeon::Reloader.require('myfile')
      File.stub!(:mtime).with(AEON_LIB + '/myfile.rb').and_return(Time.now)
      Kernel.should_receive(:load).with(AEON_LIB + '/myfile.rb')
      Aeon::Reloader.reload_modified_files!
    end
  end
end