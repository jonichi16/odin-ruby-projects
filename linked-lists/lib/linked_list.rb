# frozen_string_literal: true

require './lib/node'

# *Represent the full list
class LinkedList
  attr_accessor :head

  def initialize(value = nil)
    add_head(value)
  end

  def add_head(value = nil)
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
    current = current.next_node if current.value != value
    current.value == value
  end

  def find(value)
    return nil unless contains?(value)

    n = 0
    current = head
    until current.value == value
      current = current.next_node
      n += 1
    end
    n
  end

  def insert_at(value, index)
    if index.zero?
      prepend(value)
      return head
    end

    current = head
    prev = nil
    n = 0
    until n == index
      prev = current
      current = current.next_node
      n += 1
    end
    temp = current
    current = Node.new(value, temp)
    prev.next_node = current
    current
  end

  def remove_at(index)
    n = 0
    current = head
    removed = nil
    prev = nil
    until n == index
      prev = current
      current = current.next_node
      n += 1
    end
    removed = current
    current = removed.next_node
    prev.next_node = current
    removed
  end

  def to_s
    return 'nil' if head.nil?

    string = "( #{head.value} ) -> "
    current = head
    until current.next_node.nil?
      current = current.next_node
      string += "( #{current.value} ) -> "
    end
    "#{string} nil"
  end
end
