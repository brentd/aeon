require 'rubygems'
require 'inline'

module ChangeClass
  VERSION = '1.0.1'
end

class Object
  inline(:C) do |builder|
    builder.c <<-EOC, :method_name => :class= # FIX inline's name mapping
      VALUE class_equal(VALUE klass) {
        RBASIC(self)->klass = klass;
        return klass;
      }
    EOC
  end
end
