class Card
  CARDS_BY_VALUE = %w{
    2  3  4  5  6  7
    8  9  T  J  Q  K
    A
  }

  attr_reader :value, :suit

  def initialize(raw_card)
    @value = raw_card[0]
    @suit = raw_card[1]
  end

  def to_i
    CARDS_BY_VALUE.index(value)
  end

  def self.max(*cards)
    cards.max_by(&:to_i)
  end
end
