# frozen_string_literal: true

# * Create a node that contains data and reference to left and right node
class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data = nil, left = nil, right = nil)
    self.data = data
    self.left = left
    self.right = right
  end
end
