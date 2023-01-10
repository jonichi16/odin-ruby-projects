# frozen_string_literal: true

require './lib/node'

# *Represent the full list
class LinkedList
  attr_accessor :head

  def initialize(value = nil)
    self.head = value
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

  def size
    n = 0
    current = head
    until current.nil?
      n += 1
      current = current.next_node
    end
    n
  end

  def tail
    current = head
    current = current.next_node until current.next_node.nil?
    current
  end

  def at(index)
    return nil if (index + 1) >= size

    n = 0
    current = head
    until n == index
      current = current.next_node
      n += 1
    end
    current
  end

  def pop
    current = head
    prev = nil
    until current.next_node.nil?
      prev = current
      current = current.next_node
    end
    prev.next_node = current.next_node
    current
  end

  def contains?(value)
    current = head
    until current.next_node.nil?
      current = current.next_node
      return true if current.value == value

      return false
    end
  end
end
