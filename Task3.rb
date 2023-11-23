# frozen_string_literal: true

module Printable
  def print_info
    puts "Object info:"
    puts "Class: #{self.class}"
    puts "Object ID: #{self.object_id}"
    puts "Object variables:"
    instance_variables.each do |var|
      puts "#{var}: #{instance_variable_get(var)}"
    end
    puts "Object methods:"
    (self.methods - Object.methods).each do |method|
      puts method
    end
  end
end

class ExampleClass
  include Printable

  def initialize(name, age)
    @name = name
    @age = age
  end
end

example = ExampleClass.new("Olga Mukhina", 22)
example.print_info
puts "\n"
example2 = ExampleClass.new("Bogdan", 29)
example2.print_info
