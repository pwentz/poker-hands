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

  def self.max(hand_a, hand_b)
    winning_rank = ranks.find do |rank|
      hand_a.send("#{rank}?") || hand_b.send("#{rank}?")
    end

    tiebreaker = "#{winning_rank}_tiebreaker"

    if hand_a.send("#{winning_rank}?") && hand_b.send("#{winning_rank}?")
      if Hand.high_card_tiebreakers.include?(winning_rank)
        Hand.higher_card(hand_a, hand_b)
      elsif Hand.respond_to?(tiebreaker)
        Hand.send(tiebreaker, hand_a, hand_b)
      end
    elsif hand_a.send("#{winning_rank}?")
      hand_a
    else
      hand_b
    end
  end

  def self.higher_card(hand_a, hand_b)
    if hand_a.high.to_i > hand_b.high.to_i
      hand_a
    else
      hand_b
    end
  end

  private

  def self.ranks
    [
      :royal_flush,
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

  def self.full_house_tiebreaker(hand_a, hand_b)
    if hand_a.full_house.flatten.first.to_i > hand_b.full_house.flatten.first.to_i
      hand_a
    else
      hand_b
    end
  end

  def self.three_of_a_kind_tiebreaker(hand_a, hand_b)
    if hand_a.three_of_a_kind.first.to_i > hand_b.three_of_a_kind.first.to_i
      hand_a
    else
      hand_b
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
