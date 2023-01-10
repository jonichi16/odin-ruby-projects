# frozen_string_literal: true

require './lib/linked_list'

list = LinkedList.new(1)
list.prepend(3)
list.append(5)
list.insert_at(3, 1)
list.pop
puts list
