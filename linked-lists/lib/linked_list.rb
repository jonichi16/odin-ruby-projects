# frozen_string_literal: true

require './lib/node'

# *Represent the full list
class LinkedList
  attr_accessor :first_node

  def initialize(value = nil)
    self.first_node = value
  end

  def add_first_node(value)
    self.first_node = Node.new(value, nil)
    self
  end

  def append(value)
    return add_first_node(value) if first_node.nil?

    current = first_node
    current = current.next_node until current.next_node.nil?
    current.next_node = Node.new(value, nil)
    self
  end

  def prepend(value)
    return add_first_node(value) if first_node.nil?

    self.first_node = Node.new(value, first_node)
    self
  end

  def size
    n = 0
    current = first_node
    until current.nil?
      n += 1
      current = current.next_node
    end
    n
  end

  def head
    first_node.value
  end

  def tail
    current = first_node
    current = current.next_node until current.next_node.nil?
    current.value
  end
end
