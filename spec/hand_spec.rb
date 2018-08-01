require_relative '../lib/hand'

RSpec.describe Hand do
  # let(:cards) { "8C TS KC 9H 4S" }
  let(:hand) { Hand.new(cards) }

  xdescribe '#new' do
    context 'when input is a string' do
      it 'breaks the string on the whitespace and sets ivar' do
        expect(hand.to_a).to eq(["8C", "TS", "KC", "9H", "4S"])
      end
    end

    context 'when input is an array' do
      let(:cards) { ["8C", "TS", "KC", "9H", "4S"] }

      it 'sets the array to an ivar' do
        expect(hand.to_a).to eq(["8C", "TS", "KC", "9H", "4S"])
      end
    end
  end

  describe '#ranked' do
    let(:cards) { ["8C", "2S", "8H", "2D", "8S"].map { |c| Card.new(c) } }

    it 'returns ranked hands that cards qualify for, in descending order of value' do
      expect(hand.ranked).to eq(
        [
          :full_house,
          :three_of_a_kind,
          :one_pair
        ]
      )
    end
  end

  xdescribe '#high' do
    it 'returns the high card in the hand' do
      expect(hand.high).to eq("KC")
    end
  end
end
