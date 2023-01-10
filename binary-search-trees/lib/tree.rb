require './lib/node'

class Tree
  attr_accessor :root, :array

  def initialize(array = nil)
    self.array = array.sort.uniq
  end

  def build_tree(arr = array, start = 0, last = array.length - 1)
    return nil if start > last

    mid = (start + last) / 2
    root = Node.new(arr[mid])
    root.left = build_tree(arr, start, mid - 1)
    root.right = build_tree(arr, mid + 1, last)
    return root
  end
end