# frozen_string_literal: true

class Iterator
  include Enumerable  # Модуль, що надає набір методів для роботи з колекціями елементів, такі як:
                      # each - обов'язковий для використання, map, select, reduce, find etc

  attr_accessor :reverse,   # boolean, що відповідає зворотній ітерації
                :collection
  private :reverse,
          :collection

  def initialize(collection, reverse: false)
    @collection = collection
    @reverse = reverse
  end

  def each(&block)  #Перевизначення методу each, додавання функціоналу з оберненою ітерацією
    return @collection.reverse.each(&block) if reverse

    @collection.each(&block)
  end
end

class WordsCollection
  attr_accessor :collection
  private :collection

  def initialize(collection = [])
    @collection = collection
  end

  def iterator
    Iterator.new(@collection)
  end

  def reverse_iterator
    Iterator.new(@collection, reverse: true)
  end

  def add_item(item)
    @collection << item
  end
end

collection = WordsCollection.new
collection.add_item('One')
collection.add_item('Two')
collection.add_item('Three')
collection.add_item('Four')
collection.add_item('Five')

puts 'Straight traversal:'
collection.iterator.each { |item| puts item }

puts "\n"'Reverse traversal:'
collection.reverse_iterator.each { |item| puts item }