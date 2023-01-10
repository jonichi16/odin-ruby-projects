# frozen_string_literal: true

require './lib/node'

# *Represent the full list
class LinkedList
  attr_accessor :head

  def initialize
    self.head = nil
  end

  def add_head(value)
    self.head = Node.new(value, nil)
    self
  end

  def append(value)
    return add_head(value) if head.nil?

    current = head
    current = current.next_node until current.next_node.nil?
    current.next_node = Node.new(value, nil)
    self
  end

  def prepend(value)
    return add_head(value) if head.nil?

    self.head = Node.new(value, head)
    self
  end
end
