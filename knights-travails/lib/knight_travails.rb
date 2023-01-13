# frozen_string_literal: true

L_MOVES = [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]].freeze

# * class for creating a node
class Node
  attr_accessor :position, :moves

  def initialize(position, moves = [])
    self.position = position
    self.moves = moves
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

def found_destination(moves)
  puts "You made it in #{moves.length - 1} move(s)! Here's your path:"
  moves.each { |move| p move }
end

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def knight_moves(curr, destination, moves_taken = [])
  curr_pos = Node.new(curr, add_moves(curr))
  dest_moves = add_moves(destination)
  moves_taken.push(curr_pos.position)
  return found_destination(moves_taken) if curr == destination

  if curr_pos.moves.include?(destination)
    knight_moves(destination, destination, moves_taken)
  elsif dest_moves.intersect?(curr_pos.moves)
    common = dest_moves & curr_pos.moves
    knight_moves(common[0], destination, moves_taken)
  else
    knight_moves(curr_pos.moves[0], destination, moves_taken) unless moves_taken.include?(curr_pos.moves[0])
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength
