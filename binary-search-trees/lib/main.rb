# frozen_string_literal: true

require './lib/tree'

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = Tree.new(array)

tree.insert(116)
tree.find(324)
tree.insert(2)
tree.delete(4)
tree.pretty_print
# level_order_arr = []
# tree.level_order { |item| level_order_arr.push(item) }
# p level_order_arr
inorder_arr = []
tree.inorder { |item| inorder_arr.push(item) }
p inorder_arr
