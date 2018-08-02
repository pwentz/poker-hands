class Rank
  attr_reader :name, :high

  def initialize(name:, high:)
    @name = name
    @high = high
  end
end
