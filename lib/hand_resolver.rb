class HandResolver
  def initialize(cards)
    @cards = cards
  end

  def pair
    @cards.reduce(nil) do |latest_pair, card|
    end
  end
end
