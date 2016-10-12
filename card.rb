class Card

  attr_accessor :suit,  # => :suit
                :face,  # => :face
                :value  # => nil

  def initialize(face,suit)
    self.face = face
    self.suit = suit
    determine_value
  end                        # => :initialize

  def determine_value
    if face == "A"
      self.value = 14
    elsif face == "K"
      self.value = 13
    elsif face == "Q"
      self.value = 12
    elsif face == "J"
      self.value = 11
    else
      self.value = face.to_i
    end
  end
end

# ~> NoMethodError
# ~> undefined method `each' for nil:NilClass
# ~>
# ~> /Users/brentmwatson/documents/TheIronYard/w3d3-war/card.rb:12:in `<class:Card>'
# ~> /Users/brentmwatson/documents/TheIronYard/w3d3-war/card.rb:1:in `<main>'
