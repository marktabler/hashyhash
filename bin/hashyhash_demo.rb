require 'hashyhash'

class DemoObject
  attr_accessor :name, :id, :supervisor_id

  def initialize(name, id, supervisor_id)
    @name = name
    @id = id
    @supervisor_id = supervisor_id
  end

  def to_s
    @name
  end
end


a = DemoObject.new("Alice", 1, 1)
b = DemoObject.new("Bob", 2, 1)
c = DemoObject.new("Charlie", 3, 2)
d = DemoObject.new("David", 4, 1)

collection = [a, b, c, d]

demo_hashy = HashyHash.new(collection) do |h|
  h.unique :id
  h.foreign :supervisor_id
  h.foreign :name
end

puts "**"
puts demo_hashy.find_by_id(1) # => Alice
puts "**"
puts demo_hashy.find_by_supervisor_id(1) # => [Alice, Bob, David]
puts "**"
puts demo_hashy.find_by_name("alice") # => nil
puts "**"
puts demo_hashy.find_by_name("Alice") #= Alice
puts "**"