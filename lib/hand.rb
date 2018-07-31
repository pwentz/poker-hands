class Hand
  def initialize(cards)
    @cards = cards.is_a?(String) ? cards.split : cards
  end

  def to_a
    @cards
  end
end
