require_relative '../lib/hand_resolver'

RSpec.describe HandResolver do
  let(:resolver) { HandResolver.new(cards) }

  describe '#pair' do
    xcontext 'when there is a pair' do
      let(:cards) { ["4C", "TH", "KD", "4D", "AS"].map { |c| Card.new(c) } }

      it 'returns the pair with the card number' do
        expect(resolver.pair).to eq("4")
      end
    end
  end
end
