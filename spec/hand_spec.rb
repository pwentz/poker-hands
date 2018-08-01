require_relative '../lib/hand'

RSpec.describe Hand do
  let(:cards) { "8C TS KC 9H 4S" }
  let(:hand) { Hand.new(cards) }

  describe '#new' do
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

  describe '#score' do
    it 'calculates the hand value'

    context 'when there is no hand' do
      it 'returns nil'
    end
  end

  xdescribe '#high' do
    it 'returns the high card in the hand' do
      expect(hand.high).to eq("KC")
    end
  end
end
