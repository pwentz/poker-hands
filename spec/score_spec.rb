require './lib/score'

RSpec.describe Score do
  describe '#tally' do
    let(:full_house_hand) do
      %{KD 4H 4S KC 4C}
    end

    let(:two_pair_hand) do
      %{AD 9H 6S 9D AS}
    end

    let(:lines) do
      [
        "#{full_house_hand} #{two_pair_hand}",
        "#{full_house_hand} #{two_pair_hand}"
      ]
    end

    it 'takes a Game object and mutates it to reflect outcome' do
      game = Game.new(lines)

      Score.tally(game)

      expect(game.get_score(1)).to eq 2
      expect(game.get_score(2)).to eq 0
    end
  end
end
