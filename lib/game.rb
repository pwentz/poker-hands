require './lib/hand'
require './lib/card'

class Game
  HAND_SIZE = 5

  def initialize(lines)
    @player_count = lines.sample.split.length / HAND_SIZE

    instantiate_hands(lines)
    instantiate_scores
  end

  def get_hands(player)
    instance_variable_get("@player_#{player}_hands")
  end

  def get_score(n)
    instance_variable_get("@player_#{n}_score")
  end

  def increment_score(player)
    set_score(player, get_score(player) + 1)
  end

  def player_hands
    (1..@player_count).to_a.each_with_object({}) do |player, acc|
      acc[player] = get_hands(player)
    end
  end

  private

  def instantiate_hands(lines)
    lines.each do |line|
      line.split.each_slice(HAND_SIZE).each_with_index do |cards, idx|
        existing_hands = get_hands(idx + 1) || []

        hand = Hand.new(cards.map { |card| Card.new(card) })

        set_hands(idx + 1, [*existing_hands, hand])
      end
    end
  end

  def instantiate_scores
    @player_count.times do |player_number|
      set_score(player_number + 1, 0)
    end
  end

  def set_score(player, score)
    instance_variable_set("@player_#{player}_score", score)
  end

  def set_hands(player, hands)
    instance_variable_set("@player_#{player}_hands", hands)
  end
end
