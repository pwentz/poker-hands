class Hand
  ALL_CARDS = %w{
    1  2  3  4  5  6  7
    8  9  T  J  Q  K  A
  }

  def initialize(cards)
    @cards = cards.is_a?(String) ? cards.split : cards
  end

  def to_a
    @cards
  end

  def high
    @cards.drop(1).reduce(@cards.first) do |highest, card|
      ALL_CARDS.index(highest[0]) > ALL_CARDS.index(card[0]) ?
        highest :
        card
    end
  end
end
