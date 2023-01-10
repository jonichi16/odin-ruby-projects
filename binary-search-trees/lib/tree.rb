# frozen_string_literal: true

require './lib/node'

# * Contains the reference to the tree
class Tree
  attr_accessor :root, :array

  def initialize(array)
    self.array = array.sort.uniq
    self.root = build_tree
  end

  def build_tree(arr = array, start = 0, last = array.length - 1)
    return nil if start > last

    mid = (start + last) / 2
    current = Node.new(arr[mid])
    current.left = build_tree(arr, start, mid - 1)
    current.right = build_tree(arr, mid + 1, last)
    current
  end

  def insert(value, current = root, prev = nil)
    if current.nil?
      if value < prev.data
        prev.left = Node.new(value)
      else
        prev.right = Node.new(value)
      end
      return
    end

    value < current.data ? insert(value, current.left, current) : insert(value, current.right, current)
  end
end
