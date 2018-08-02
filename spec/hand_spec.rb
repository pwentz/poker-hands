require_relative '../lib/hand'

RSpec.describe Hand do
  let(:hand) { Hand.new(cards) }

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

  describe '#high' do
    context 'when there is a single high card in the hand' do
      let(:high_card) { Card.new("JS") }
      let(:cards) do
        [
          Card.new("2H"),
          Card.new("8D"),
          Card.new("9S"),
          high_card,
          Card.new("TC")
        ]
      end

      it 'returns the high card' do
        expect(hand.high).to be(high_card)
      end
    end

    context 'when there are multiple cards w/ same value' do
      let(:high_card) { Card.new("JS") }
      let(:another_high_card) { Card.new("JC") }
      let(:cards) do
        [
          Card.new("2H"),
          Card.new("8D"),
          Card.new("9S"),
          high_card,
          another_high_card
        ]
      end

      it 'returns the first high card' do
        expect(hand.high).to be(high_card)
      end
    end
  end

  describe '.max' do
    let(:cards) do
      [
        Card.new("8C"),
        Card.new("4D"),
        Card.new("8H"),
        Card.new("8D"),
        Card.new("4C"),
      ]
    end
    let(:hand_b) do
      Hand.new(hand_b_cards)
    end
    let(:hand_b_cards) do
      [
        Card.new("AS"),
        Card.new("TH"),
        Card.new("TD"),
        Card.new("TS"),
        Card.new("4C")
      ]
    end

    it 'returns the hand with the higher rank' do
      expect(Hand.max(hand, hand_b)).to eq(hand)
    end

    context 'when both hands have a royal flush' do
      let(:cards) do
        [
          Card.new("TC"),
          Card.new("QC"),
          Card.new("KC"),
          Card.new("AC"),
          Card.new("JC"),
        ]
      end
      let(:hand_b_cards) do
        [
          Card.new("TH"),
          Card.new("QH"),
          Card.new("KH"),
          Card.new("AH"),
          Card.new("JH"),
        ]
      end

      it 'returns nil' do
        expect(Hand.max(hand, hand_b)).to be_nil
      end
    end
  end
end
