require_relative "deck"  # => true
include Comparable

class Game
  attr_accessor :player1_deck,
                :player2_deck,  # => nil
                :play_war

  def initialize
    self.player1_deck = Deck.new
    self.player2_deck = Deck.new
  end                             # => :initialize

  def play_war
    promt
    play_card
    decide_winner
    ask_for_rematch
  end

  def play_card

    if self.player1_deck.cards.value > self.player1_deck.cards.value
      play_winner = player1
    elsif self.player1_deck.cards.value < self.player1_deck.cards.value
      play_winner = player2
    else
      play winner = "war"
    end

    self.player1_deck.shift
    self.player2_deck.shift

  end


  def decide_winner

  end
  # player 1 winning
  # player 2 winnings
  # of wars


# initialize decks?
# initialize Game
# initialize players
# player 1 plays draw?
# player 2 plays draw?
# player 1 deck shift
# player 2 deck shift


end  # => :initialize
