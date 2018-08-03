require './lib/card'
require './lib/rank_resolver'

class Hand
  RANK_NAMES = [
    :royal_flush,
    :straight_flush,
    :four_of_a_kind,
    :full_house,
    :flush,
    :straight,
    :three_of_a_kind,
    :two_pair,
    :one_pair
  ]

  attr_reader :cards

  def initialize(cards)
    @cards = cards
    @resolver = RankResolver.new(cards)
  end

  def high_card
    Card.max(*cards)
  end

  def rank_name
    RANK_NAMES.find do |rank|
      self.send("#{rank}?")
    end
  end

  def to_a
    cards.map(&:value).zip(cards.map(&:suit)).map(&:join)
  end

  def method_missing(method, *args)
    if @resolver.respond_to?(method)
      @resolver.send(method, *args)
    else
      super
    end
  end

  class << self
    def max(*hands)
      top_rank_name = RANK_NAMES.find do |rank_name|
        hands.any? { |hand| hand.rank_name == rank_name }
      end

      return high_card_hand(*hands) if top_rank_name.nil?

      winning_hands = hands.find_all { |hand| hand.send("#{top_rank_name}?") }

      if winning_hands.length >= 2
        tiebreaker(top_rank_name, *winning_hands)
      else
        winning_hands.first
      end
    end

    private

    def high_card_hand(*hands)
      hands.max_by { |hand| hand.high_card.to_i }
    end

    def tiebreaker(rank_name, *hands)
      return if rank_name == :royal_flush

      hands.max_by do |hand|
        hand.send(rank_name).high
      end
    end
  end
end
