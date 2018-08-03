require './lib/game'

class Score
  def self.tally(game)
    game.player_hands.values.sample.length.times do |idx|
      comparing_hands = game
        .player_hands
        .transform_values { |hands| hands[idx] }

      game.increment_score(winner(comparing_hands))
    end
  end

  private

  def self.winner(hand_by_player)
    winning_hand = Hand.max(*hand_by_player.values)

    hand_by_player.keys.find do |player|
      winning_hand == hand_by_player[player]
    end
  end
end
