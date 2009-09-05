module Aeon
  class Character
    include DataMapper::Resource
    
    property :id,   Serial
    property :name, String
    
    belongs_to :player
    belongs_to :room
    
    def become_animated(animator)
      @animator = animator
      self.room ||= Aeon::Room.default_room
      self
    end
    
    def move(direction)
      if destination = room.send(direction)
        update_attributes(:room => destination)
      end
    end
  end
end