require_relative './card'
require_relative './hand_resolver'

class Hand
  def initialize(cards)
    @cards = cards
    @resolver = HandResolver.new(cards)
  end

  def to_a
    @cards
  end

  def high
  end

  def score
  end

  # TODO:
  #   - delete this, it's not needed
  #   - instead just provide tiebreakers (lambdas?)
  #     for each rank (most are high card, others are
  #     high card of match (SEE BELOW)
  #
  def ranked
    [
      :royal_flush,
      :straight_flush,
      :four_of_a_kind,
      :full_house,
      :flush,
      :straight,
      :three_of_a_kind,
      :two_pairs,
      :one_pair
    ].find_all { |method| self.send("#{method}?") }
  end

  def method_missing(method, *args)
    if @resolver.respond_to?(method)
      @resolver.send(method, *args)
    else
      super
    end
  end
end

# Ranks that you have to account cards for during a tie:
# - Royal Flush (high card)
# - Straight Flush (high card)
# - Straight (high card)
# - Flush (high card)
# - Four of a kind (high quadruplet wins) ---|
# - Full house (high triplet wins)           | Can possibly send methods to
# - Three of a kind (high triplet wins)      | resolver and grab first after
# - two pairs     (high pair wins)           | flattening
# - one pair      (high pair wins)        ---|
#
# Final tiebreaker:
# - High card
