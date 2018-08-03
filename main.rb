require './lib/game'
require './lib/score'
require './lib/file_reader'

class Main
  class << self
    def go
      lines = FileReader.readlines(File.join('public', 'poker.txt'))
      game = Game.new(lines)

      Score.tally(game)

      puts "---------- RESULTS ----------"
      game.player_hands.keys.each do |player|
        puts "PLAYER #{player}: #{game.get_score(player)} WON HANDS"
      end
    end
  end
end

Main.go
