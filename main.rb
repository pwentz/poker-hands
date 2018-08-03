require './lib/hand'
require './lib/parser'

# Make Score ds
# Move #tally to somewhere else and test it
# fix issue w/ ranks and reusing same symbols

class Main
  class << self
    def go
      final_score = tally

      puts "---------- RESULTS ----------"
      log_player_score(1, final_score[:player_1])
      log_player_score(2, final_score[:player_2])
    end

    private

    def player_hands
      @player_hands ||= Parser.new.txt('./public/poker.txt')
    end

    def tally
      scores = {player_1: 0, player_2: 0}
      player_hands[:player_1].zip(player_hands[:player_2]).each_with_object(scores) do |(player_1, player_2), score|
        if Hand.max(player_1, player_2) == player_1
          scores[:player_1] = scores[:player_1] + 1
        else
          scores[:player_2] = scores[:player_2] + 1
        end
      end
    end

    def log_player_score(player_number, player_score)
      puts "PLAYER #{player_number}: #{player_score} WON HANDS"
    end
  end
end

Main.go
