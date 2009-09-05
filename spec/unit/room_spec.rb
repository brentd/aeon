require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Aeon::Room do
  describe "#link" do
    [:north, :east, :south, :west, :up, :down].each do |direction|
      it "should link #{direction}" do
        r1 = Aeon::Room.new
        r2 = Aeon::Room.new
        
        r1.link(r2, direction)
        
        opposite = Aeon::Room.opposite(direction)
        r1.send(direction).should == r2  # r1.east.should == r2
        r2.send(opposite).should  == r1  # r2.west.should == r1
        
        r1.send("#{direction}_id").should == r2.id  # r1.east_id.should == r2.id
        r2.send("#{opposite}_id").should  == r1.id  # r2.west_id.should == r1.id
      end
    end
    
    describe "in the same zone" do
      it "should require that rooms are adjacent" do
        r1 = Aeon::Room.new(:x => 0, :y => 0)
        r2 = Aeon::Room.new(:x => 2, :y => 0)
        lambda { r1.link(r2, :east) }.should raise_error(Aeon::ImpossibleLinkError)
      end

      it "should require that rooms are in the proper coordinates" do
        r1 = Aeon::Room.new(x: 0, y: 0)
        r2 = Aeon::Room.new(x: 0, y: 1)
        lambda { r1.link(r2, :east) }.should raise_error(Aeon::ImpossibleLinkError)
      end
      
      it "should assign coordinates when linking" do
        r1 = Aeon::Room.new(:x => 0, :y => 0)
        r2 = Aeon::Room.new
        r1.link(r2, :east)

        r2.coords.should == Vector[1,0,0,0]
      end
    end
    
    describe "in different zones" do
      it "should not require that rooms are adjacent when in different zones" do
        r1 = Aeon::Room.new
        r2 = Aeon::Room.new(zone: 9)
        lambda { r1.link(r2, :north) }.should_not raise_error(Aeon::ImpossibleLinkError)
      end
    end
  end
  
  describe "autolink" do
    it "should automatically link adjacent rooms" do
      r1 = Aeon::Room.create(x: 0, y: 0, autolink: true)
      r2 = Aeon::Room.create(x: 0, y: 1)
      
      r2.reload.south.should == r1
      r1.reload.north.should == r2
    end
    
    it "should preserve existing links" do
      r1 = Aeon::Room.create(x: 0, y: 0)
      r2 = Aeon::Room.create(x: 1, y: 0)
      
      r1.link(r2, :east)
      
      r1.autolink = true
      r1.save
      
      r1.reload.east.should == r2
    end
    
    it "should preserve existing links to other zones" do
      room = Aeon::Room.create(name: "Room 0,0", x: 0, y: 0, zone: 0, autolink: true)
      room_in_another_zone = Aeon::Room.create(name: "Room in another zone", zone: 5)
      
      room.link(room_in_another_zone, :east)

      east_room = Aeon::Room.create(name: "Room 1,0", x: 1, y: 0, zone: 0, autolink: true)
      
      room.reload.east.should == room_in_another_zone
      room_in_another_zone.reload.west.should == room
      
      east_room.reload.west.should == nil
    end
  end
  
  describe "coordinate plane" do
    it "#has_coordinates?" do
      room = Aeon::Room.new
      room.should_not have_coordinates
      
      room.x, room.y = 0, 0
      room.should have_coordinates
      room.save
      room.should have_coordinates
    end
    
    it "should not allow rooms at the same coordinates" do
      lambda {
        Aeon::Room.create(:x => 0, :y => 0)
        Aeon::Room.create(:x => 0, :y => 0)
      }.should raise_error(Aeon::RoomExistsAtCoordinatesError)
    end
  end
end