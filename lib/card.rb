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

  def self.max(*cards)
    cards.reduce do |highest, card|
      if CARDS_BY_VALUE.index(highest.value) >= CARDS_BY_VALUE.index(card.value)
        highest
      else
        card
      end
    end
  end
end
