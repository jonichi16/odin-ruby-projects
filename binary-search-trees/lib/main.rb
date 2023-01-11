# frozen_string_literal: true

require './lib/tree'

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = Tree.new(array)

tree.insert(123)
tree.insert(174)
tree.insert(157)
tree.pretty_print
p tree.height(8)
p tree.depth(1)
p tree.balanced?
tree.rebalance
p tree.balanced?
tree.pretty_print
