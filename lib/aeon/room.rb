require 'matrix'

module Aeon
  class RoomExistsAtCoordinatesError < StandardError; end
  class ImpossibleLinkError < StandardError; end
  
  class Room
    include DataMapper::Resource
  
    property :id,           Serial
    property :name,         String
    property :description,  Text,    :lazy => false
    property :autolink,     Boolean
    property :x,            Integer
    property :y,            Integer
    property :z,            Integer, :default => 0
    property :zone,         Integer, :default => 0
  
    # The associations below read a bit funny, but it's quite simple:
    #
    #   r1.east = r2   # sets r1.east_id to r2.id
    #   r2.west = r1   # sets r2.west_id to r1.id
    #
    belongs_to :north, :class_name => "Room", :child_key => [:north_id]
    belongs_to :south, :class_name => "Room", :child_key => [:south_id]
    belongs_to :east,  :class_name => "Room", :child_key => [:east_id]
    belongs_to :west,  :class_name => "Room", :child_key => [:west_id]
    belongs_to :up,    :class_name => "Room", :child_key => [:up_id]
    belongs_to :down,  :class_name => "Room", :child_key => [:down_id]
    
    has n, :characters
    
    before :save, :set_coordinates
    before :save, :autolink!
    
    DIRECTIONS = [:north, :south, :east, :west, :up, :down]
    
    VECTORS_BY_DIRECTION = {
      :north => Vector[ 0, 1, 0, 0],
      :south => Vector[ 0,-1, 0, 0],
      :east  => Vector[ 1, 0, 0, 0],
      :west  => Vector[-1, 0, 0, 0],
      :up    => Vector[ 0, 0, 1, 0],
      :down  => Vector[ 0, 0,-1, 0]
    }
    
    DIRECTIONS_BY_VECTOR = VECTORS_BY_DIRECTION.invert
    
    OPPOSITES = {
      :north => :south,
      :south => :north,
      :east  => :west,
      :west  => :east,
      :up    => :down,
      :down  => :up
    }
    
    def self.find_by_coords(coords, extra_conditions={})
      conditions = { x:    coords[0],
                     y:    coords[1],
                     z:    (coords[2] || 0),
                     zone: (coords[3] || 0) }
      first(conditions.merge!(extra_conditions))
    end
    
    def self.default_room
      Aeon::Room.first || Aeon::Room.create(:name => "The Void")
    end
    
    def self.opposite(direction)
      OPPOSITES[direction.to_sym]
    end
    
    def render
      lines = []
      lines << name
      lines << description
      lines += characters.collect(&:name)
      lines.join("\n")
    end
    
    def inspect
      exits_hash = exits.inject({}) {|h, (dir,room)| h[dir] = room.id; h}
      "#<Aeon::Room id=#{id.inspect} name=#{name.inspect}" +
      " coords=#{coords.to_a.inspect} exits=#{exits_hash.inspect}>"
    end
    
    def link(room, direction)
      opposite = Room.opposite(direction)
            
      transaction do
        set_coordinates
        
        if !room.has_coordinates?
          room.coords = coordinates_to(direction)
        elsif !linkable?(room, direction)
          raise(ImpossibleLinkError)
        end
                                                   # Example:
        unlink(direction)                          # unlink(:east)
        self.update_attributes(direction => room)  # self.update_attributes(:east => room)
        room.update_attributes(opposite => self)   # room.update_attributes(:west => self)
      end
            
      room
    end
    
    def unlink(direction)
      opposite = Room.opposite(direction)
                                                        # Example:
      if linked_room = send(direction)                  # if linked_room = east
        linked_room.update_attributes(opposite => nil)  #   linked_room.update_attributes(:west => nil)
      end                                               # end
      update_attributes(direction => nil)               # update_attributes(:east => nil)
            
      linked_room
    end
    
    # Checks whether or not `room` can be linked to this room in `direction`.
    # If the rooms are in the same zone and the coordinates don't make sense,
    # returns false.
    #
    # @example
    #   r1 = Room.new(x: 0, y: 0)
    #   r2 = Room.new(x: 1, y: 0)
    #   r3 = Room.new(x: 9, y: 9)
    #
    #   r1.linkable?(r1, :east) #=> true
    #   r1.linkable?(r3, :east) #=> false
    def linkable?(room, direction)
      if room.zone == zone && room.has_coordinates?
        room.coords == coordinates_to(direction)
      else
        true
      end
    end
    
    def linked?(direction_or_room)
      reload
      if direction_or_room.is_a?(Symbol)
        !!exits[direction_or_room]
      else
        exits.values.collect(&:id).include?(direction_or_room.id)
      end
    end
    
    # @return [Hash] rooms connected to this one indexed by direction
    def exits
      hash = {}
      DIRECTIONS.each do |direction|
        if room = send(direction)
          hash[direction] = room
        end
      end
      hash
    end
    
    # @return [Vector] The coordinates of this room as: [x, y, z, zone]
    def coords
      Vector[x, y, z, zone]
    end
    
    def coords=(coords)
      self.x, self.y, self.z, self.zone = coords.to_a
      self.coords
    end
    
    def has_coordinates?
      coords.to_a.all?
    end
    
    def adjacent?(room)
      !!direction_to(room)
    end
    
    def changed_coordinates? 
      [:x, :y, :z, :zone].any? {|a| attribute_dirty?(a)}
    end
    
    # @return [Hash] rooms directly adjacent to this room on the coordinate
    #   plane, indexed by direction. Note that this doesn't only include rooms 
    #   that are actually linked to this room.
    def adjacent_rooms
      adjacents = {}
      VECTORS_BY_DIRECTION.each do |direction, vector|
        if room = Room.find_by_coords(coordinates_to(direction))
          adjacents[direction] = room
        end
      end
      adjacents
    end
    
    def autolink!
      # Since this happens after every save, these initial checks are
      # necessary to avoid an infinite loop.
      if changed_coordinates? && !@performing_autolink
        begin
          @performing_autolink = true 
          adjacent_rooms.each do |direction, room|
            if (autolink? || room.autolink?) && !room.linked?(Room.opposite(direction))
              link(room, direction)
            end
          end
        ensure
          @performing_autolink = false
        end
      end
      self
    end
    
    # @return [Vector] coordinates to the `direction` of this room
    def coordinates_to(direction)
      coords + VECTORS_BY_DIRECTION[direction.to_sym]
    end
    
    # @return [Symbol] the direction `room` is from this room
    def direction_to(room)
      DIRECTIONS_BY_VECTOR[room.coords - coords]
    end
    
    private
    
    # Sets coordinates of the room to the origin (0,0) if not set. Raises
    # RoomExistsAtCoordinatesError if a room already exists at the room's
    # coordinates. Called before save.
    def set_coordinates
      self.x ||= 0
      self.y ||= 0
      if existing_room = Room.find_by_coords(coords, :id.not => self.id)
        raise(RoomExistsAtCoordinatesError, "Room exists: #{existing_room.inspect}") 
      end
    end
    
  end
end