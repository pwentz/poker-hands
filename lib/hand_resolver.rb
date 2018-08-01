require_relative 'rank'

class HandResolver
  def initialize(cards)
    @cards = cards
  end

  # TODO:
  #  - consider just having a Result object that the resolver returns
  #  - this Result object will have just two properties:
  #     - rank
  #     - high
  #
  #  - WHY?
  #     - this will eliminate the need for tiebreakers
  #       if you can just return the hand with the highest result
  #     - also, the logic for resolving hands and tiebreakers is in one spot

  def pairs
    return unless one_pair? || two_pairs?

    Rank.new(
      name: one_pair? ? :one_pair : :two_pair,
      high: n_of_a_kind(2).flatten.map(&:to_i).max
    )
  end

  def two_pairs?
    n_of_a_kind(2).length == 2
  end

  def one_pair?
    n_of_a_kind(2).length == 1
  end

#   def three_of_a_kind
#     Result.new(
#       rank: :three_of_a_kind,
#       high: n_of_a_kind(3).flatten.first
#     )
#   end

  def three_of_a_kind
    n_of_a_kind(3).first
  end

  def three_of_a_kind?
    !!three_of_a_kind
  end

  def four_of_a_kind
    n_of_a_kind(4).first
  end

  def four_of_a_kind?
    !!four_of_a_kind
  end

  def full_house
    three_of_a_kind = n_of_a_kind(3).first
    two_of_a_kind = n_of_a_kind(2).first

    if three_of_a_kind && two_of_a_kind
      [three_of_a_kind, two_of_a_kind]
    end
  end

  def full_house?
    !!full_house
  end

  def straight?
    first, *rest = sorted_cards.map(&:to_i)

    rest.reduce({ continue?: true, last: first }) do |acc, n|
      {
        continue?: acc[:continue?] && (acc[:last] + 1 == n),
        last: n
      }
    end[:continue?]
  end

  def flush?
    @cards.map(&:suit).uniq.length == 1
  end

  def straight_flush?
    straight? && flush?
  end

  def royal_flush?
    flush? &&
      sorted_cards.map(&:value) == %w{T J Q K A}
  end

  private

  def n_of_a_kind(n)
    @cards
      .group_by(&:value)
      .values
      .find_all do |matches|
        n.is_a?(Range) ?
          n.cover?(matches.length) :
          matches.length == n
      end
  end

  def sorted_cards
    @cards.sort_by(&:to_i)
  end
end
