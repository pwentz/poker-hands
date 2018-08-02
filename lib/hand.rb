require_relative './card'
require_relative './rank_resolver'

class Hand
  def initialize(cards)
    @cards = cards
    @resolver = RankResolver.new(cards)
  end

  def to_a
    @cards
  end

  def high
    @cards.sort_by { |card| -card.to_i }.first
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

  def self.max(*hands)
    winning_rank = ranks.find do |rank|
      hands.any? { |hand| hand.send("#{rank}?") }
    end

    return Hand.higher_card(*hands) if winning_rank.nil?

    winning_hands = hands.find_all { |hand| hand.send("#{winning_rank}?") }

    if winning_hands.length >= 2
      return if winning_rank == :royal_flush
      winning_hands.max_by { |hand| hand.send(winning_rank).high }
    else
      winning_hands.first
    end
  end

  def self.higher_card(*hands)
    hands.max_by { |hand| hand.high.to_i }
  end

  private

  def self.tiebreaker(rank, *hands)
    tiebreaker_method = "#{rank}_tiebreaker"

    if Hand.high_card_tiebreakers.include?(rank)
      Hand.higher_card(*hands)
    elsif Hand.respond_to?(tiebreaker_method)
      Hand.send(tiebreaker_method, *hands)
    end
  end

  def self.ranks
    [
      :royal_flush,
      :four_of_a_kind,
      :full_house,
      :three_of_a_kind
    ]
  end

  def self.high_card_tiebreakers
    [
      :straight,
      :straight_flush,
      :flush
    ]
  end

  def self.full_house_tiebreaker(*hands)
    hands.max_by { |hand| hand.full_house.flatten.first.to_i }
  end

  def self.three_of_a_kind_tiebreaker(*hands)
    hands.max_by { |hand| hand.three_of_a_kind.first.to_i }
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
