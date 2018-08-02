require_relative '../lib/hand'

RSpec.describe Hand do
  let(:hand) { Hand.new(cards) }

  describe '#high_card' do
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
        expect(hand.high_card).to be(high_card)
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
        expect(hand.high_card).to be(high_card)
      end
    end
  end

  describe '#rank_name' do
    context 'when a hand could qualify for multiple ranks' do
      let(:cards) do
        ["TS", "7H", "7C", "TC", "TD"].map { |c| Card.new(c) }
      end

      it 'returns the highest rank that hand has achieved' do
        expect(hand.rank_name).to be :full_house
      end
    end

    context 'when a hand does not qualify for any ranks' do
      let(:cards) do
        ["TS", "2H", "7C", "4D", "JS"].map { |c| Card.new(c) }
      end

      it 'returns the highest rank that hand has achieved' do
        expect(hand.rank_name).to be_nil
      end
    end
  end

  describe '#to_a' do
    let(:string_cards) do
      ["8S", "TD", "QH", "5C", "6S"]
    end

    let(:cards) do
      string_cards.map { |c| Card.new(c) }
    end

    it 'returns an array of string representations of cards' do
      expect(hand.to_a).to eq(string_cards)
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

    context 'when both hands have a full house' do
      let(:cards) do
        ["9C", "9H", "6H", "9D", "6S"].map { |c| Card.new(c) }
      end

      let(:hand_b_cards) do
        ["8H", "8C", "8D", "7D", "7H"].map { |c| Card.new(c) }
      end

      it 'returns the hand with the higher three-of-a-kind' do
        expect(Hand.max(hand, hand_b)).to be hand
      end
    end

    context 'when both hands have a flush' do
      let(:cards) do
        ["3C", "6C", "2C", "9C", "JC"].map { |c| Card.new(c) }
      end

      let(:hand_b_cards) do
        ["8H", "QH", "4H", "TH", "5H"].map { |c| Card.new(c) }
      end

      it 'returns the hand with the high card' do
        expect(Hand.max(hand, hand_b)).to be hand_b
      end
    end

    context 'when both hands have a straight' do
      let(:cards) do
        ["3C", "6D", "5S", "4C", "7H"].map { |c| Card.new(c) }
      end

      let(:hand_b_cards) do
        ["8C", "9H", "6H", "TD", "7C"].map { |c| Card.new(c) }
      end

      it 'returns the hand with the high card' do
        expect(Hand.max(hand, hand_b)).to be hand_b
      end
    end

    context 'when both hands have three-of-a-kind' do
      let(:cards) do
        ["TC", "6D", "TS", "4C", "TH"].map { |c| Card.new(c) }
      end

      let(:hand_b_cards) do
        ["7C", "QH", "6H", "7S", "7D"].map { |c| Card.new(c) }
      end

      it 'returns the hand with the higher three-of-a-kind' do
        expect(Hand.max(hand, hand_b)).to be hand
      end
    end

    context 'when both hands have two pairs' do
      let(:cards) do
        ["TS", "AD", "4S", "4C", "TH"].map { |c| Card.new(c) }
      end

      let(:hand_b_cards) do
        ["JC", "JH", "9H", "7S", "9D"].map { |c| Card.new(c) }
      end

      it 'returns the hand with the highest pair' do
        expect(Hand.max(hand, hand_b)).to be hand_b
      end
    end

    context 'when both hands have one pair' do
      let(:cards) do
        ["2C", "QH", "9H", "7S", "QD"].map { |c| Card.new(c) }
      end

      let(:hand_b_cards) do
        ["AS", "6D", "JS", "4C", "JH"].map { |c| Card.new(c) }
      end

      it 'returns the hand with the high pair' do
        expect(Hand.max(hand, hand_b)).to be hand
      end
    end

    context 'when both hands have no ranks' do
      let(:cards) do
        ["2C", "4H", "9H", "7S", "JD"].map { |c| Card.new(c) }
      end

      let(:hand_b_cards) do
        ["TS", "6D", "QS", "4C", "3H"].map { |c| Card.new(c) }
      end

      it 'returns the hand with the high card' do
        expect(Hand.max(hand, hand_b)).to be hand_b
      end
    end

    context 'more than two hands' do
      # 3 of a kind (9)
      let(:cards) do
        ["TC", "9C", "KC", "9D", "9H"].map { |c| Card.new(c) }
      end

      # two pair
      let(:hand_b_cards) do
        ["TH", "TD", "6H", "AH", "6D"].map { |c| Card.new(c) }
      end

      # 3 of a kind (4)
      let(:hand_c) do
        Hand.new(["4C", "TH", "4S", "JC", "4D"].map { |c| Card.new(c) })
      end

      it 'returns nil' do
        expect(Hand.max(hand, hand_b, hand_c)).to be hand
      end
    end
  end
end
