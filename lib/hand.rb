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
    @cards.max_by(&:to_i)
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

    return higher_card(*hands) if winning_rank.nil?

    winning_hands = hands.find_all { |hand| hand.send("#{winning_rank}?") }

    if winning_hands.length >= 2
      tiebreaker(winning_rank, *winning_hands)
    else
      winning_hands.first
    end
  end

  def self.higher_card(*hands)
    hands.max_by { |hand| hand.high.to_i }
  end

  private

  def self.tiebreaker(rank, *hands)
    return if rank == :royal_flush

    hands.max_by do |hand|
      hand.send(rank).high
    end
  end

  def self.ranks
    [
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
  end
end
