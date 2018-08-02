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
      ["8C", "4D", "8H", "8D", "4C"].map { |c| Card.new(c) }
    end

    let(:hand_b) do
      Hand.new(hand_b_cards)
    end

    let(:hand_b_cards) do
      ["AS", "TH", "TD", "TS", "4C"].map { |c| Card.new(c) }
    end

    it 'returns the hand with the higher rank' do
      expect(Hand.max(hand, hand_b)).to be(hand)
    end

    context 'when both hands have a royal flush' do
      let(:cards) do
        ["TC", "QC", "KC", "AC", "JC"].map { |c| Card.new(c) }
      end

      let(:hand_b_cards) do
        ["TH", "QH", "KH", "AH", "JH"].map { |c| Card.new(c) }
      end

      it 'returns nil' do
        expect(Hand.max(hand, hand_b)).to be_nil
      end
    end

    context 'when both hands have a straight flush' do
      let(:cards) do
        ["4C", "7C", "6C", "8C", "5C"].map { |c| Card.new(c) }
      end

      let(:hand_b_cards) do
        ["TH", "8H", "7H", "9H", "6H"].map { |c| Card.new(c) }
      end

      it 'returns the hand with the high card' do
        expect(Hand.max(hand, hand_b)).to be hand_b
      end
    end

    context 'when both hands have a four of a kind' do
      let(:cards) do
        ["9C", "9H", "6S", "9D", "9S"].map { |c| Card.new(c) }
      end

      let(:hand_b_cards) do
        ["TH", "6C", "6H", "6D", "6H"].map { |c| Card.new(c) }
      end

      it 'returns the hand with the high card' do
        expect(Hand.max(hand, hand_b)).to be hand
      end
    end
  end
end
