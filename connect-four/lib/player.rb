# frozen_string_literal: true

# * Class for creating a player
class Player
  attr_reader :name, :token

  def initialize(name, token)
    @name = name
    @token = token
  end
end
