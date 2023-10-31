# frozen_string_literal: true
# Підключення gem
require 'merkletree'

# Створення дерева Меркла за допомогою списка значень
mrkl = MerkleTree.new('1', '2', '3', '4', '5')

# Виведення кореня дерева
puts "Root of the Merkle Tree: #{mrkl.root.value}"

# Виведення листів дерева
puts "\nLeaves of the Merkle Tree: #{mrkl.leaves}"

# Виведення хешів всіх вузлів дерева
pp mrkl

# Створення дерева Меркла за допомогою списку транзакцій
# Використовує to_s для кожної транзакції та записує
# отриманий «серіалізований» рядок для обчислення криптографічного хешу
merkle = MerkleTree.for(
  { from: "Marie",      to: "Max",        what: "Cake",           qty: 3 },
  { from: "Petya",      to: "Vlad",       what: "Ice cream",      qty: 2 },
  { from: "Anne",       to: "Dima",       what: "Candy",          qty: 4 },
  { from: "Anton",      to: "Julia",      what: "Pie",            qty: 5 } )

puts "\nRoot of the Merkle Tree (transaction): #{merkle.root.value}"

puts "\nLeaves of the Merkle Tree (transaction): #{merkle.leaves}"

pp merkle
