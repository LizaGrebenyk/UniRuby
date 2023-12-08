# frozen_string_literal: true

# Клас, який імітує роботу з базою даних
class Database
  # Симулюємо запит до бази даних
  def query(sql)
    puts "Виконання запиту до бази даних: #{sql}"
    # У реальному застосуванні тут була б логіка доступу до бази даних
    "result_of_#{sql}"
  end
end

# Клас замісника, який використовується для кешування запитів до бази даних
class DatabaseProxy
  def initialize(real_database)
    @real_database = real_database # Справжній об'єкт бази даних
    @cache = {} # Хеш-таблиця для кешування результатів запитів
  end

  # Метод, який виконує запит через проксі
  def query(sql)
    # Перевіряємо, чи результат запиту вже кешовано
    unless @cache.key?(sql)
      puts "Кешування результату для запиту: #{sql}"
      # Якщо результат не в кеші, виконуємо запит через справжню базу даних
      # і зберігаємо результат в кеш
      @cache[sql] = @real_database.query(sql)
    end
    # Повертаємо результат з кешу
    @cache[sql]
  end
end

# Використання проксі
database = Database.new # Створюємо об'єкт бази даних
proxy = DatabaseProxy.new(database) # Створюємо об'єкт проксі для бази даних

# Виконуємо запит через проксі. Перший раз запит виконується і результат кешується.
puts proxy.query("SELECT * FROM users")

# При повторному запиті результат береться з кешу, що економить ресурси
puts proxy.query("SELECT * FROM users")
