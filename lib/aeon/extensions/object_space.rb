module ObjectSpace

  # @return <Array[Class]> All the classes in the object space.
  def self.classes
    klasses = []
    ObjectSpace.each_object(Class) {|o| klasses << o}
    klasses
  end

end
