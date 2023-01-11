# frozen_string_literal: true

require './lib/tree'

# * Script

array = Array.new(15) { rand(1..100) }
tree = Tree.new(array)
puts ' The First Binary Search Tree '.center(50, '*')
puts ''
tree.pretty_print
puts "\n○ This tree is #{tree.balanced? ? 'balanced' : 'not balanced'}"

level_array = []
tree.level_order { |item| level_array.push(item) }
puts "\n○ Level Order Traversal: #{level_array}"

preorder_array = []
tree.preorder { |item| preorder_array.push(item) }
puts "\n○ Pre-order Traversal: #{preorder_array}"

postorder_array = []
tree.postorder { |item| postorder_array.push(item) }
puts "\n○ Post-order Traversal: #{postorder_array}"

inorder_array = []
tree.inorder { |item| inorder_array.push(item) }
puts "\n○ Inorder Traversal: #{inorder_array}"

10.times { tree.insert(rand(100..200)) }
puts ''
puts ' The New Binary Search Tree '.center(50, '*')
puts ''
tree.pretty_print
puts "\n○ This tree is #{tree.balanced? ? 'balanced' : 'not balanced'}"

puts ''
puts ' The Balanced New Binary Search Tree '.center(50, '*')
puts ''
tree.rebalance
tree.pretty_print
puts "\n○ This tree is #{tree.balanced? ? 'balanced' : 'not balanced'}"

level_array = []
tree.level_order { |item| level_array.push(item) }
puts "\n○ Level Order Traversal: #{level_array}"

preorder_array = []
tree.preorder { |item| preorder_array.push(item) }
puts "\n○ Pre-order Traversal: #{preorder_array}"

postorder_array = []
tree.postorder { |item| postorder_array.push(item) }
puts "\n○ Post-order Traversal: #{postorder_array}"

inorder_array = []
tree.inorder { |item| inorder_array.push(item) }
puts "\n○ Inorder Traversal: #{inorder_array}"
