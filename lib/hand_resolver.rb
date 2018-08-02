require_relative 'rank'

class HandResolver
  def initialize(cards)
    @cards = cards
  end

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

  def three_of_a_kind
    return unless three_of_a_kind?

    Rank.new(
      name: :three_of_a_kind,
      high: n_of_a_kind(3).flatten.first.to_i
    )
  end

  def three_of_a_kind?
    n_of_a_kind(3).flatten.any?
  end

  def four_of_a_kind
    return unless four_of_a_kind?

    Rank.new(
      name: :four_of_a_kind,
      high: n_of_a_kind(4).flatten.first.to_i
    )
  end

  def four_of_a_kind?
    n_of_a_kind(4).flatten.any?
  end

  def full_house
    return unless full_house?

    Rank.new(
      name: :full_house,
      high: [n_of_a_kind(3), n_of_a_kind(2)].flatten.map(&:to_i).max
    )
  end

  def full_house?
    !!(n_of_a_kind(3).first && n_of_a_kind(2).first)
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
      .find_all { |matches| matches.length == n }
  end

  def sorted_cards
    @cards.sort_by(&:to_i)
  end
end
