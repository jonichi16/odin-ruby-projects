# frozen_string_literal: true

L_MOVES = [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]].freeze

# * class for creating a node
class Node
  attr_accessor :position, :move

  def initialize(position, move = [])
    self.position = position
    self.move = move
  end
end

def add_moves(position)
  valid_moves = []
  L_MOVES.each do |move|
    x = move[0] + position[0]
    y = move[1] + position[1]
    next if !(1..8).include?(x) || !(1..8).include?(y)

    valid_moves.push([x, y])
  end
  valid_moves
end

def knight_moves(position, destination)
  Node.new(position, add_moves(position))
end
