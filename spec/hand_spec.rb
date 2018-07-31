require_relative '../lib/hand'

RSpec.describe Hand do
  describe '#new' do
    context 'when input is a string' do
      it 'breaks the string on the whitespace' do
        hand = Hand.new("8C TS KC 9H 4S")

        expect(hand.to_a).to eq(["8C", "TS", "KC", "9H", "4S"])
      end
    end

    context 'when input is an array' do
      it 'does nothing' do
        hand = Hand.new(["8C", "TS", "KC", "9H", "4S"])

        expect(hand.to_a).to eq(["8C", "TS", "KC", "9H", "4S"])
      end
    end
  end
end
