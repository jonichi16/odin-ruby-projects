# frozen_string_literal: true

# *This will create the player instance
class Player
  attr_accessor :name, :character

  def initialize(name, character)
    self.name = name
    self.character = character
  end
end
