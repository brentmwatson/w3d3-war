class Card

  attr_accessor :suit,
                :face,
                :value

  def initialize(face,suit)
    self.face = face
    self.suit = suit
    determine_value
  end

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
