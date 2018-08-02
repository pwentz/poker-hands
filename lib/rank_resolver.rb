require_relative 'rank'

class RankResolver
  def initialize(cards)
    @cards = cards
  end

  def one_pair?
    n_of_a_kind(2).length == 1
  end

  def one_pair
    return unless one_pair?

    Rank.new(
      name: :one_pair,
      high: n_of_a_kind(2).flatten.map(&:to_i).max
    )
  end

  def two_pair?
    n_of_a_kind(2).length == 2
  end

  def two_pair
    return unless two_pair?

    Rank.new(
      name: :two_pair,
      high: n_of_a_kind(2).flatten.map(&:to_i).max
    )
  end

  def three_of_a_kind?
    n_of_a_kind(3).flatten.any?
  end

  def three_of_a_kind
    return unless three_of_a_kind?

    Rank.new(
      name: :three_of_a_kind,
      high: n_of_a_kind(3).flatten.first.to_i
    )
  end

  def four_of_a_kind?
    n_of_a_kind(4).flatten.any?
  end

  def four_of_a_kind
    return unless four_of_a_kind?

    Rank.new(
      name: :four_of_a_kind,
      high: n_of_a_kind(4).flatten.first.to_i
    )
  end

  def full_house?
    !!(n_of_a_kind(3).first && n_of_a_kind(2).first)
  end

  def full_house
    return unless full_house?

    Rank.new(
      name: :full_house,
      high: [n_of_a_kind(3), n_of_a_kind(2)].flatten.map(&:to_i).max
    )
  end

  def straight?
    sorted_vals = sorted_cards.map(&:to_i)
    sorted_vals == (sorted_vals.min..sorted_vals.min + 4).to_a
  end

  def straight
    return unless straight?

    Rank.new(
      name: :straight,
      high: high_card.to_i
    )
  end

  def flush?
    @cards.map(&:suit).uniq.length == 1
  end

  def flush
    return unless flush?

    Rank.new(
      name: :flush,
      high: high_card.to_i
    )
  end

  def straight_flush?
    straight? && flush?
  end

  def straight_flush
    return unless straight_flush?

    Rank.new(
      name: :straight_flush,
      high: high_card.to_i
    )
  end

  def royal_flush?
    flush? &&
      sorted_cards.map(&:value) == %w{T J Q K A}
  end

  def royal_flush
    return unless royal_flush?

    Rank.new(
      name: :royal_flush,
      high: high_card.to_i
    )
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

  def high_card
    sorted_cards.last
  end
end
