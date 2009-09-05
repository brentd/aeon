Given /^a (\d+)x(\d+) area of rooms$/ do |width, height|
  (0...height.to_i).each do |y|
    (0...width.to_i).each do |x|
      Aeon::Room.create(x: x, y: y, name: "Room #{x},#{y}", autolink: true)
    end
  end
end

Given /^a room$/ do
  @room = Aeon::Room.create(x: 0, y: 0, name: "Room 0,0")
end

# Example: Given "r2" is east of "r1"
Given /^"([^\"]*)" is (\w+) (?:of|from) "([^\"]*)"$/ do |r2_name, direction, r1_name|
  r1 = Aeon::Room.first(name: r1_name) || Aeon::Room.new(name: r1_name)
  r2 = Aeon::Room.first(name: r2_name) || Aeon::Room.new(name: r2_name)

  r1.link(r2, direction)
end