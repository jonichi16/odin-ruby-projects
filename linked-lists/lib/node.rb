# frozen_string_literal: true

# *Create a node that contains a value and reference to the next node
class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    self.value = value
    self.next_node = next_node
  end
end
