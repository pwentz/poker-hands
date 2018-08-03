require_relative '../lib/game'

RSpec.describe Game do
  let(:player_1_hand) { %w{JS 5C 6H TC 3S} }
  let(:player_2_hand) { %w{QH 2C 9S 5D 8H} }
  let(:hands) { ["#{player_1_hand.join(" ")} #{player_2_hand.join(" ")}"] }
  let(:game) { Game.new(hands) }

  describe '#get_score' do
    it 'gets the score of the player number passed' do
      expect(game.get_score(2)).to eq 0
    end
  end

  describe '#get_hands' do
    it 'gets the hand of the player number passed' do
      expect(game.get_hands(1).map(&:to_a)).to eq [player_1_hand]
      expect(game.get_hands(2).map(&:to_a)).to eq [player_2_hand]
    end
  end

  describe '#increment_score' do
    it 'increments the score of the player number passed' do
      game.increment_score(2)

      expect(game.get_score(2)).to eq 1
    end
  end

  describe '#hands' do
    it 'returns a hash of all the players and their hands' do
      res = game.hands.transform_values { |hands| hands.map(&:to_a) }

      expect(res).to eq({
        1 => [player_1_hand],
        2 => [player_2_hand]
      })
    end
  end
end
