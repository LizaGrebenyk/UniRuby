# frozen_string_literal: true

def example_method_positional(arg1, arg2, arg3)
  puts arg1, arg2, arg3
end

example_method_positional("value1", "value2", "value3")

def example_method_named(arg1:, arg2:, arg3:)
  puts arg1, arg2, arg3
end

example_method_named(arg3: "value3", arg1: "value1", arg2: "value2")