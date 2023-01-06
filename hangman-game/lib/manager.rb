# frozen_string_literal: true

require 'yaml'

# *Module for saving game data
module Save
  def save_game(fname)
    Dir.mkdir 'saved' unless Dir.exist? 'saved'

    File.open("./saved/#{fname}.yaml", 'w') { |file| file.puts YAML.dump(self) }
  end

  def load_game(file)
    filename = Dir.glob('./saved/*.yaml')[file - 1]
    game = YAML.load_file(
      filename,
      permitted_classes: [Game]
    )
    game.start
  end
end
