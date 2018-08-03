require './lib/card'

RSpec.describe Card do
  describe "#value" do
    it 'returns the string value of the card' do
      card = Card.new("8C")

      expect(card.value).to eq("8")
    end
  end

  describe '#suit' do
    it 'returns the string suit of the card' do
      card = Card.new("8C")

      expect(card.suit).to eq("C")
    end
  end

  describe '#compare' do
    context 'when one card has higher value than the other' do
      it 'returns the card with the higher value' do
        card_a = Card.new("QC")
        card_b = Card.new("3D")
        card_c = Card.new("AS")
        card_d = Card.new("8H")

        expect(Card.max(card_a, card_b, card_c, card_d)).to be(card_c)
      end
    end

    context 'when two cards share the same value' do
      it 'returns the first card' do
        card_a = Card.new("QC")
        card_b = Card.new("QD")
        card_c = Card.new("8H")

        expect(Card.max(card_a, card_b, card_c)).to be(card_a)
      end
    end
  end
end
