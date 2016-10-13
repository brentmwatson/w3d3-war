require_relative "card"

class Deck

  attr_accessor :cards

  def initialize
      self.cards = []
      make_cards
      shuffle
  end

  def make_cards
    face = %w(2 3 4 5 6 7 8 9 10 J Q K A)
    suit = %w(spade club heart diamond)

    suit.each do |x|
      face.each do |y|
        cards << Card.new(y, x)
      end
    end
  end

  def draw
    cards.shift
  end

  def shuffle
    cards.shuffle!
  end

end
