require './lib/rank_resolver'

RSpec.describe RankResolver do
  let(:resolver) { RankResolver.new(cards.map { |c| Card.new(c) }) }

  describe '#one_pair' do
    context 'when there is a pair' do
      let(:cards) do
        ["4C", "TH", "KD", "4D", "AS"]
      end

      it 'returns a rank object' do
        expect(resolver.one_pair?).to be true
        expect(resolver.one_pair.name).to eq :one_pair
        expect(resolver.one_pair.high).to eq 2
      end
    end

    context 'when there are no pairs' do
      let(:cards) do
        ["4C", "5H", "TS", "4D", "4H"]
      end

      it 'returns an empty array' do
        expect(resolver.one_pair?).to be false
        expect(resolver.one_pair).to be_nil
      end
    end
  end

  describe '#two_pair' do
    context 'when there are multiple pairs' do
      let(:cards) do
        ["4C", "KH", "4D", "TD", "TS"]
      end

      it 'returns the pairs in descending order of value' do
        expect(resolver.two_pair?).to be true
        expect(resolver.two_pair.name).to eq :two_pair
        expect(resolver.two_pair.high).to eq 8
        # 2 3 4 5 6 7 8 9 T J Q  K  A
        # 0 1 2 3 4 5 6 7 8 9 10 11 12
      end
    end

    context 'when there are no pairs' do
      let(:cards) do
        ["4C", "5H", "TS", "4D", "4H"]
      end

      it 'returns an empty array' do
        expect(resolver.two_pair?).to be false
        expect(resolver.two_pair).to be_nil
      end
    end
  end

  describe '#three_of_a_kind' do
    context 'when there is three of a kind' do
      let(:cards) do
        ["5H", "9D", "5S", "TC", "5D"]
      end

      it 'returns the cards' do
        expect(resolver.three_of_a_kind?).to be true
        expect(resolver.three_of_a_kind.name).to eq :three_of_a_kind
        expect(resolver.three_of_a_kind.high).to eq 3
      end
    end

    context 'when there is no three of a kind' do
      let(:cards) do
        ["4C", "TH", "4D", "KD", "KS"]
      end

      it 'returns the pairs in descending order of value' do
        expect(resolver.three_of_a_kind?).to be false
        expect(resolver.three_of_a_kind).to be_nil
      end
    end
  end

  describe '#straight' do
    context 'when there is a straight in play' do
      let(:cards) do
        ["8C", "5H", "9C", "6D", "7S"]
      end

      it 'returns true' do
        expect(resolver.straight?).to be true
        expect(resolver.straight.name).to be :straight
        expect(resolver.straight.high).to be 7
      end
    end

    context 'when there is no straight in play' do
      let(:cards) do
        ["8C", "5H", "9C", "6D", "TS"]
      end

      it 'returns false' do
        expect(resolver.straight?).to be false
        expect(resolver.straight).to be_nil
      end
    end
  end

  describe '#flush' do
    context 'when there is a flush in play' do
      let(:cards) do
        ["KS", "8S", "2S", "6S", "JS"]
      end

      it 'returns true' do
        expect(resolver.flush?).to be true
        expect(resolver.flush.name).to be :flush
        expect(resolver.flush.high).to be 11
      end
    end

    context 'when there is no flush in play' do
      let(:cards) do
        ["KS", "8S", "2S", "6H", "JS"]
      end

      it 'returns false' do
        expect(resolver.flush?).to be false
        expect(resolver.flush).to be_nil
      end
    end
  end

  describe '#full_house' do
    context 'when there is a full house' do
      let(:cards) do
        ["7C", "7D", "KD", "7H", "KS"]
      end

      it 'returns the pairs in descending order of value' do
        expect(resolver.full_house?).to be true
        expect(resolver.full_house.name).to eq :full_house
        expect(resolver.full_house.high).to eq 5
      end
    end

    context 'when there is no full house' do
      let(:cards) do
        ["AS", "TH", "TD", "TS", "4C"]
      end

      it 'returns nil' do
        expect(resolver.full_house?).to be false
        expect(resolver.full_house).to be_nil
      end
    end
  end

  describe '#four_of_a_kind' do
    context 'when there is a four-of-a-kind present' do
      let(:cards) do
        ["4C", "TH", "4D", "4H", "4S"]
      end

      it 'returns the pairs in descending order of value' do
        expect(resolver.four_of_a_kind?).to be true
        expect(resolver.four_of_a_kind.name).to eq :four_of_a_kind
        expect(resolver.four_of_a_kind.high).to eq 2
      end
    end

    context 'when there is not a four-of-a-kind' do
      let(:cards) do
        ["2S", "8S", "2H", "8C", "2D"]
      end

      it 'returns nil' do
        expect(resolver.four_of_a_kind?).to be false
        expect(resolver.four_of_a_kind).to be_nil
      end
    end
  end

  describe '#straight_flush' do
    context 'when a straight flush is present' do
      let(:cards) do
        ["8C", "5C", "9C", "6C", "7C"]
      end

      it 'returns true' do
        expect(resolver.straight_flush?).to be true
        expect(resolver.straight_flush.name).to be :straight_flush
        expect(resolver.straight_flush.high).to be 7
      end
    end

    context 'when a straight flush is not present' do
      let(:cards) do
        ["8C", "5C", "KC", "6C", "7C"]
      end

      it 'returns true' do
        expect(resolver.straight_flush?).to be false
        expect(resolver.straight_flush).to be_nil
      end
    end
  end

  describe '#royal_flush' do
    context 'when a royal flush is present' do
      let(:cards) do
        ["KC", "QC", "JC", "TC", "AC"]
      end

      it 'returns true' do
        expect(resolver.royal_flush?).to be true
        expect(resolver.royal_flush.name).to be :royal_flush
        expect(resolver.royal_flush.high).to be 12
      end
    end

    context 'when a royal flush is not present' do
      let(:cards) do
        ["KC", "QC", "JC", "TC", "AD"]
      end

      it 'returns true' do
        expect(resolver.royal_flush?).to be false
        expect(resolver.royal_flush).to be_nil
      end
    end
  end
end
