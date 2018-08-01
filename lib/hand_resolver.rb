class HandResolver
  def initialize(cards)
    @cards = cards
  end

  def pairs
    n_of_a_kind(2).sort_by { |matches| -matches.first.to_i }
  end

  def two_pairs?
    pairs.length == 2
  end

  def one_pair?
    pairs.length == 1
  end

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
