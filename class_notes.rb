class Die

  include Comparable

  attr_accessor :sides, :exposed_side

  def initialize(num = 6)
    self.sides = (1..num).collect{|x| x}
  end

  def roll
    self.exposed_side = sides.sample
  end

  def <=>(other)
    exposed_side <=> other.exposed_side
  end

  def +(other)
    exposed_side + other.exposed_side
  end

  def coerce(other)
    [other, exposed_side]
  end

end
# *********************
require_relative 'die'

class Game

  attr_accessor :player_dice, :computer_dice

  def initialize
    self.player_dice = 6.times.collect { Die.new }
    self.computer_dice = 6.times.collect { Die.new }
  end

  def turn(player)
    if player == "player"
      player_dice.each { |die| die.roll }
    else
      computer_dice.each { |die| die.roll }
    end
  end

  def total(player)
    if player == "player"
      player_dice.reduce(:+)
    else
      computer_dice.reduce(:+)
    end
  end

  def winner
    if total("player") > total("computer")
      "player"
    elsif total("player") < total("computer")
      "computer"
    else
      "tie"
    end
  end

  def loser
    possibles = %w(player computer tie) - [winner]
    if possibles.include?("tie")
      (possibles -= ["tie"]).first
    else
      "tie"
    end
  end

end
Contact GitHub API Training Shop Blog About
