require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "DataMapper Global IdentityMap" do
  it "should load a given record only once" do
    room = Aeon::Room.gen
    Aeon::Room.first.object_id.should == room.object_id
    Aeon::Room.get(1).object_id.should == room.object_id
  end
  
  it "should load a given record only once for many-to-one associations" do
    room = Aeon::Room.gen
    character = Aeon::Character.gen(:room => room)
    # Use __send__(:parent) to get to the actual Room object, since
    # character.room is a proxy which does not forward object_id.
    character.room.__send__(:parent).object_id.should == room.object_id
    character.room.reload
    character.room.__send__(:parent).object_id.should == room.object_id
  end
  
  it "should load a given record only once for one-to-many associations" do
    room = Aeon::Room.gen
    character1 = Aeon::Character.gen(:room => room)
    character2 = Aeon::Character.gen(:room => room)
    room.characters.first.object_id.should == character1.object_id
    room.characters.last.object_id.should  == character2.object_id
    room.characters[0].object_id.should == character1.object_id
    room.characters[1].object_id.should == character2.object_id
    room.reload
    room.characters.reload
    room.characters[0].object_id.should == character1.object_id
    room.characters[1].object_id.should == character2.object_id
  end
end