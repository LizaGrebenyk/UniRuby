# frozen_string_literal: true

# Використання стандартних обробників винятків
# Метод для ділення двох чисел із обробкою винятку ділення на нуль
def divide_numbers(x, y)
  begin
    # Спроба ділення
    result = x / y
  rescue ZeroDivisionError => e
    # Обробка винятку, якщо відбувається ділення на нуль
    puts "Помилка ділення на нуль: #{e.message}"
    # Установка результату в nil у випадку помилки
    result = nil
  ensure
    # Код в цьому блоку виконується завжди, незалежно від помилки
    puts "Операція ділення завершена"
  end
  # Повернення результату операції
  result
end

# Використання методу
puts divide_numbers(10, 2)   # Виведе результат ділення
puts divide_numbers(10, 0)   # Виведе повідомлення про помилку

# Використання створеного класу обробника винятків
class ValidationError < StandardError
  attr_reader :field  # Додаткове поле для зберігання інформації про поле, де відбулася помилка

  # Ініціалізатор з додатковим параметром field
  def initialize(message, field)
    super(message)  # Виклик конструктора батьківського класу
    @field = field  # Зберігання інформації про поле
  end
end

# Метод для валідації віку
def validate_age(age)
  # Генерація винятку ValidationError, якщо вік невалідний
  raise ValidationError.new("Вік повинен бути більшим за 0", :age) if age <= 0
  puts "Вік валідний"
end

# Блок для перехоплення та обробки винятку
begin
  validate_age(-5)
rescue ValidationError => e
  # Виведення повідомлення про помилку
  puts "Помилка валідації: #{e.message} у полі '#{e.field}'"
end

