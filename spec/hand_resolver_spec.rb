require_relative '../lib/hand_resolver'

RSpec.describe HandResolver do
  let(:resolver) { HandResolver.new(cards) }

  describe '#pairs' do
    context 'when there is a pair' do
      let(:match_1a) { Card.new("4C") }
      let(:match_1b) { Card.new("4D") }
      let(:cards) do
        [
          match_1a,
          Card.new("TH"),
          Card.new("KD"),
          match_1b,
          Card.new("AS")
        ]
      end

      it 'returns a rank object' do
        expect(resolver.one_pair?).to be(true)
        expect(resolver.pairs.name).to eq(:one_pair)
      end
    end

    context 'when there are multiple pairs' do
      let(:match_1a) { Card.new("4C") }
      let(:match_1b) { Card.new("4D") }
      let(:match_2a) { Card.new("KD") }
      let(:match_2b) { Card.new("KS") }
      let(:cards) do
        [
          match_1a,
          Card.new("TH"),
          match_2a,
          match_1b,
          match_2b
        ]
      end

      it 'returns the pairs in descending order of value' do
        expect(resolver.two_pairs?).to be(true)
        expect(resolver.pairs.name).to eq(:two_pair)
        expect(resolver.pairs.high).to eq(11)
        # 2 3 4 5 6 7 8 9 T J Q  K  A
        # 0 1 2 3 4 5 6 7 8 9 10 11 12
      end
    end

    context 'when there are no pairs' do
      let(:cards) do
        [
          "4C",
          "5H",
          "TS",
          "4D",
          "4H"
        ].map { |c| Card.new(c) }
      end

      it 'returns an empty array' do
        expect(resolver.one_pair?).to be(false)
        expect(resolver.two_pairs?).to be(false)
        expect(resolver.pairs).to be_nil
      end
    end
  end

  describe '#three_of_a_kind' do
    context 'when there is three of a kind' do
      let(:match_1a) { Card.new("5H") }
      let(:match_1b) { Card.new("5S") }
      let(:match_1c) { Card.new("5D") }
      let(:cards) do
        [
          match_1a,
          Card.new("9D"),
          match_1b,
          Card.new("TC"),
          match_1c
        ]
      end

      it 'returns the cards' do
        expect(resolver.three_of_a_kind?).to be(true)
        expect(resolver.three_of_a_kind.name).to eq(:three_of_a_kind)
        expect(resolver.three_of_a_kind.high).to eq(3)
      end
    end

    context 'when there is no three of a kind' do
      let(:cards) do
        ["4C", "TH", "4D", "KD", "KS"].map { |c| Card.new(c) }
      end

      it 'returns the pairs in descending order of value' do
        expect(resolver.three_of_a_kind?).to be(false)
        expect(resolver.three_of_a_kind).to be_nil
      end
    end
  end

  # describe '#straight?' do
    # context 'when there is a straight in play' do
    #   let(:cards) do
    #     ["8C", "5H", "9C", "6D", "7S"].map { |c| Card.new(c) }
    #   end

    #   it 'returns true' do
    #     expect(resolver.straight?).to be(true)
    #   end
    # end

    # context 'when there is no straight in play' do
    #   let(:cards) do
    #     ["8C", "5H", "9C", "6D", "TS"].map { |c| Card.new(c) }
    #   end

    #   it 'returns false' do
    #     expect(resolver.straight?).to be(false)
    #   end
    # end
  # end

  # describe '#flush?' do
    # context 'when there is a flush in play' do
    #   let(:cards) do
    #     ["KS", "8S", "2S", "6S", "JS"].map { |c| Card.new(c) }
    #   end

    #   it 'returns true' do
    #     expect(resolver.flush?).to be(true)
    #   end
    # end

    # context 'when there is no flush in play' do
    #   let(:cards) do
    #     ["KS", "8S", "2S", "6H", "JS"].map { |c| Card.new(c) }
    #   end

    #   it 'returns false' do
    #     expect(resolver.flush?).to be(false)
    #   end
    # end
  # end

  # describe '#full_house' do
    # context 'when there is a full house' do
    #   let(:match_1a) { Card.new("7C") }
    #   let(:match_1b) { Card.new("7D") }
    #   let(:match_2a) { Card.new("KD") }
    #   let(:match_1c) { Card.new("7H") }
    #   let(:match_2b) { Card.new("KS") }
    #   let(:cards) do
    #     [
    #       match_1a,
    #       match_1b,
    #       match_2a,
    #       match_1c,
    #       match_2b
    #     ]
    #   end

    #   it 'returns the pairs in descending order of value' do
    #     expect(resolver.full_house?).to be(true)
    #     expect(resolver.full_house).to eq([
    #       [match_1a, match_1b, match_1c],
    #       [match_2a, match_2b]
    #     ])
    #   end
    # end

    # context 'when there is no full house' do
    #   let(:cards) do
    #     ["AS", "TH", "TD", "TS", "4C"].map { |c| Card.new(c) }
    #   end

    #   it 'returns nil' do
    #     expect(resolver.full_house?).to be(false)
    #     expect(resolver.full_house).to be_nil
    #   end
    # end
  # end

  # describe '#four_of_a_kind' do
    # context 'when there is a four-of-a-kind present' do
    #   let(:match_1a) { Card.new("4C") }
    #   let(:match_1b) { Card.new("4D") }
    #   let(:match_1c) { Card.new("4H") }
    #   let(:match_1d) { Card.new("4S") }
    #   let(:cards) do
    #     [
    #       match_1a,
    #       Card.new("TH"),
    #       match_1b,
    #       match_1c,
    #       match_1d
    #     ]
    #   end

    #   it 'returns the pairs in descending order of value' do
    #     expect(resolver.four_of_a_kind?).to be(true)
    #     expect(resolver.four_of_a_kind).to eq([
    #       match_1a, match_1b, match_1c, match_1d
    #     ])
    #   end
    # end

    # context 'when there is not a four-of-a-kind' do
    #   let(:cards) do
    #     ["2S", "8S", "2H", "8C", "2D"].map { |c| Card.new(c) }
    #   end

    #   it 'returns nil' do
    #     expect(resolver.four_of_a_kind?).to be(false)
    #     expect(resolver.four_of_a_kind).to be_nil
    #   end
    # end
  # end

  # describe '#straight_flush?' do
    # context 'when a straight flush is present' do
    #   let(:cards) do
    #     ["8C", "5C", "9C", "6C", "7C"].map { |c| Card.new(c) }
    #   end

    #   it 'returns true' do
    #     expect(resolver.straight_flush?).to be(true)
    #   end
    # end

    # context 'when a straight flush is not present' do
    #   let(:cards) do
    #     ["8C", "5C", "KC", "6C", "7C"].map { |c| Card.new(c) }
    #   end

    #   it 'returns true' do
    #     expect(resolver.straight_flush?).to be(false)
    #   end
    # end
  # end

  # describe '#royal_flush?' do
    # context 'when a royal flush is present' do
    #   let(:cards) do
    #     ["KC", "QC", "JC", "TC", "AC"].map { |c| Card.new(c) }
    #   end

    #   it 'returns true' do
    #     expect(resolver.royal_flush?).to be(true)
    #   end
    # end

    # context 'when a royal flush is not present' do
    #   let(:cards) do
    #     ["KC", "QC", "JC", "TC", "AD"].map { |c| Card.new(c) }
    #   end

    #   it 'returns true' do
    #     expect(resolver.royal_flush?).to be(false)
    #   end
    # end
  # end
end
