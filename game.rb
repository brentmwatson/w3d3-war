require_relative "deck"  # => true
include Comparable       # => Object

class Game
  attr_accessor :player1_deck,  # => :player1_deck
                :player2_deck,  # => :player2_deck
                :play_war       # => nil

  def initialize
    self.player1_deck = Deck.new
    self.player2_deck = Deck.new
  end                             # => :initialize

  def play_war
    promt
    play_round
    decide_winner
    ask_for_rematch
  end                # => :play_war

  def play_round
    if self.player1_deck.cards.value > self.player1_deck.cards.value
      round_winner = player1
    elsif self.player1_deck.cards.value < self.player1_deck.cards.value
      round_winner = player2
    else
      round_winner = "war"
    end
    self.player1_deck.shift
    self.player2_deck.shift
  end                                     # => :play_round


  def total_round_outcome (round_winner)
    if round_winner == player1
      round_winner.reduce(:+)
    elsif round_winner == player2
      round_winner.reduce(:+)
    else
      round_winner.reduce(:+)
    end
  end                                     # => :total_round_outcome

  # def overall_winner
  #   if total("player1") > total ("player2")
  #     "player1"
  #   else
  #     "player2"
  #   end
  #
  # end
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


end  # => :total_round_outcome
