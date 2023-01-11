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

  def insert(value, current = root)
    if current.nil?
      current = Node.new(value)
      return current
    end

    if value < current.data
      current.left = insert(value, current.left)
    elsif value > current.data
      current.right = insert(value, current.right)
    end

    current
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
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
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  def min_value(root)
    min = root.data
    until root.left.nil?
      min = root.left.data
      root = root.left
    end
    min
  end

  def find(value, current = root)
    if value < current.data
      find(value, current.left)
    elsif value > current.data
      find(value, current.right)
    else
      pretty_print(current)
    end
  end

  # rubocop:disable Style/OptionalBooleanParameter
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
  # rubocop:enable Style/OptionalBooleanParameter
end
