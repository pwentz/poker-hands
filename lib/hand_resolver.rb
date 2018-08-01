class HandResolver
  def initialize(cards)
    @cards = cards
  end

  def pairs
    n_of_a_kind(2).sort_by { |matches| -matches.first.to_i }
  end

  def three_of_a_kind
    n_of_a_kind(3).first
  end

  def four_of_a_kind
    n_of_a_kind(4).first
  end

  def straight?
    sorted_cards = @cards.sort_by(&:to_i)

    sorted_cards
      .drop(1)
      .reduce({continue?: true, last: sorted_cards.first }) do |acc, card|
        acc.merge({
          continue?: acc[:continue?] && (acc[:last].to_i + 1 == card.to_i),
          last: card
        })
      end[:continue?]
  end

  def flush?
    @cards.map(&:suit).uniq.length == 1
  end

  def full_house
    n_of_a_kind(2..3).sort_by { |matches| -matches.length }
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

# Four of a Kind: Four cards of the same value.
# Straight Flush: All cards are consecutive values of same suit.
# Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
end
