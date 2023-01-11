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
      return prev.left = Node.new(value) if value < prev.data

      return prev.right = Node.new(value)

    end

    return current if current.data == value

    value < current.data ? insert(value, current.left, current) : insert(value, current.right, current)
  end

  def delete(value, current = root)
    return current if current.nil?

    if value < current.data
      current.left = delete(value, current.left)
    elsif value > current.data
      current.right = delete(value, current.right)
    else
      return current.right if current.left.nil?
      return current.left if current.right.nil?

      current.data = min_value(current.right)
      current.right = delete(current.data, current.right)
    end

    current
  end

  def min_value(root)
    min = root.data
    until root.left.nil?
      min = root.left.data
      root = root.left
    end
    min
  end
end
