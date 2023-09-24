# frozen_string_literal: true

class Iterator
  def initialize(array)
    @array = array
    @index = 0
  end

  def first   # Повертає перший елемент у колекції
    @array[0]
  end

  def next    # Повертає поточний елемент і збільшує індекс для наступного виклику
    value = @array[@index]
    @index += 1 if has_next?
    value
  end

  def is_done?    # Повертає чи вказує індекс на останній елемент
    @index == @array.length - 1
  end

  def current_item    # Повертає поточний елемент
    @array[@index]
  end

  def has_next?   # Перевірка чи існує наступний елемент
    @index < @array.length
  end

  def previous  # Повертає поточний елемент і зменшує індекс для наступного виклику
    value = @array[@index]
    @index -= 1 if has_previous?
    value
  end

  def has_previous?   # Перевірка чи існує попередній елемент
    @index > 0
  end

  def rewind    # Повертає індекс на початок колекції
    @index = 0
  end
end

fruits = ['orange', 'apple', 'mango']
array_iterator = Iterator.new(fruits)

while array_iterator.has_next?
  puts array_iterator.next
end