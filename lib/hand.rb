require_relative './card'
require_relative './rank_resolver'

class Hand
  RANKS = [
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

  def high
    @cards.max_by(&:to_i)
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
      winning_rank = RANKS.find do |rank|
        hands.any? { |hand| hand.send("#{rank}?") }
      end

      return highest_card(*hands) if winning_rank.nil?

      winning_hands = hands.find_all { |hand| hand.send("#{winning_rank}?") }

      if winning_hands.length >= 2
        tiebreaker(winning_rank, *winning_hands)
      else
        winning_hands.first
      end
    end

    def highest_card(*hands)
      hands.max_by { |hand| hand.high.to_i }
    end

    private

    def tiebreaker(rank, *hands)
      return if rank == :royal_flush

      hands.max_by do |hand|
        hand.send(rank).high
      end
    end
  end
end
