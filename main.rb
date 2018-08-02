require './lib/hand'
require './lib/parser'

class Main
  class << self
    def go
      final_score = tally

      puts
      puts "---------- RESULTS ----------"
      puts "PLAYER 1: #{final_score[:player_1]} WON HANDS"
      puts "PLAYER 2: #{final_score[:player_2]} WON HANDS"
    end

    private

    def hands_by_player
      @hands_by_player ||= Parser.new.txt('./public/poker.txt')
    end

    def tally
      scores = {player_1: 0, player_2: 0}
      hands_by_player[:player_1].zip(hands_by_player[:player_2]).reduce(scores) do |scores, (player_1_hand, player_2_hand)|
        puts "----------------------------------------"
        puts "PLAYER 1: #{player_1_hand.to_a} (#{player_1_hand.rank || "high card"})"
        puts "PLAYER 2: #{player_2_hand.to_a} (#{player_2_hand.rank || "high card"})"
        puts "============="
        if Hand.max(player_1_hand, player_2_hand) == player_1_hand
          puts "WINNER: PLAYER ONE"
          scores.merge({ player_1: scores[:player_1] + 1 })
        else
          puts "WINNER: PLAYER TWO"
          scores.merge({ player_2: scores[:player_2] + 1 })
        end
      end
    end
  end
end

Main.go
