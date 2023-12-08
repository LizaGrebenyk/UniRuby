# frozen_string_literal: true

# Клас, що представляє вузол у пов'язаному списку
class Node
  attr_accessor :next  # Атрибут для зберігання посилання на наступний вузол
  attr_reader :value   # Атрибут для зберігання значення вузла

  # Ініціалізатор вузла
  def initialize(value, next_node = nil)
    @value = value      # Зберігає значення, передане при створенні вузла
    @next = next_node   # Зберігає посилання на наступний вузол (за замовчуванням nil)
  end

  # Метод для перетворення вузла у рядок
  def to_s
    "Node value: #{@value}"
  end
end

# Клас, що представляє пов'язаний список
class LinkedList
  def initialize
    @head = nil  # Початок списку ініціалізується як nil
  end

  # Додавання нового вузла в кінець списку
  def append(value)
    # Якщо список не порожній, знаходимо останній вузол і додаємо за ним новий вузол
    # В іншому випадку новий вузол стає головою списку
    @head ? find_tail.next = Node.new(value) : @head = Node.new(value)
  end

  # Знаходження останнього вузла в списку
  def find_tail
    node = @head
    node = node.next while node&.next
    node
  end

  # Додавання нового вузла після вузла з певним значенням
  def append_after(target, value)
    node = find(target)
    node.next = Node.new(value, node.next) if node
  end

  # Пошук вузла за значенням
  def find(value)
    node = @head
    node = node.next while node && node.value != value
    node
  end

  # Видалення вузла за значенням
  def delete(value)
    if @head&.value == value
      @head = @head.next
      return
    end
    node = find_before(value)
    node.next = node.next&.next if node&.next
  end

  # Пошук вузла, що знаходиться перед вузлом з певним значенням
  def find_before(value)
    node = @head
    node = node.next while node&.next && node.next.value != value
    node
  end

  # Виведення всіх вузлів списку
  def print
    values = []
    node = @head
    while node
      values << node.value
      node = node.next
    end
    puts "Linked list: " + values.join(' ')
  end
end

# Демонстрація роботи з пов'язаним списком
list = LinkedList.new
list.append(10)
list.append(20)
list.append(30)
list.print
list.append_after(10, 15)
list.append_after(20, 25)
list.print
list.delete(15)
list.print
puts list.find_before(30).to_s
puts list.find_tail.to_s