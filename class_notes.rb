class Die

  include Comparable  # => Die

  attr_accessor :sides, :exposed_side  # => nil

  def initialize(num = 6)
    self.sides = (1..num).collect{|x| x}
  end                                     # => :initialize

  def roll
    self.exposed_side = sides.sample
  end                                 # => :roll

  def <=>(other)
    exposed_side <=> other.exposed_side
  end                                    # => :<=>

  def +(other)
    exposed_side + other.exposed_side
  end                                  # => :+

  def coerce(other)
    [other, exposed_side]
  end                      # => :coerce

end                     # => :coerce
# *********************
require_relative 'die'  # ~> LoadError: cannot load such file -- /Users/brentmwatson/documents/TheIronYard/w3d3-war/die

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

require 'timeout'
# **********************************
class Game

  def self.bulk_play(num = 1000)
    num.times do
      instrument
    end
    output_report
  end

  def self.output_report
    valid_options.push("tie").each do |outcome|
      puts "#{outcome.capitalize}: #{results[outcome]}"
    end
    puts "#{big_winner.capitalize} is our overall winner."
  end

  def self.big_winner
    results.max_by { |outcome, wins| wins }.first
  end

  def self.results
    @results ||= Hash.new(0)
    # if defined?(@results)
    #   @results
    # else
    #   @results = Hash.new(0)
    # end
  end

  def self.instrument
    game = Game.new(true)
    game.player_choice = valid_options.sample
    game.computer_choice = valid_options.sample
    if game.pick_a_winner.start_with? "PLAYER WINS!"
      results[game.player_choice] += 1
    elsif game.pick_a_winner.start_with? "COMPUTER WINS!"
      results[game.computer_choice] += 1
    else
      results["tie"] += 1
    end
  end

  def self.valid_options
    %w(rock paper scissors spock lizard)
  end

  attr_accessor :player_choice,
                :computer_choice,
                :starter,
                :test_mode

  def initialize(test_mode = false)
    self.starter = true
    self.test_mode = test_mode
  end

  def play
    prologue if starter
    computer_pick
    player_pick
    pick_a_winner
    ask_for_rematch
  end

  def valid_options
    self.class.valid_options
  end

  def prologue
    output("Let's play #{valid_options.map(&:capitalize).join("-")}.")
  end

  def computer_pick
    self.computer_choice = valid_options.sample
  end

  def player_pick(words = "Make your selection ...")
    output(words)
    self.player_choice = gets.chomp.downcase
    verify_pick
  end

  def verify_pick
    player_pick("Pick a valid option, please") unless valid_pick?
  end

  def valid_pick?
    valid_options.include? player_choice
  end

  def winning_conditions
    [
      %w(paper rock),
      %w(rock scissors),
      %w(scissors paper),
      %w(lizard spock),
      %w(rock lizard),
      %w(spock scissors),
      %w(scissors lizard),
      %w(lizard paper),
      %w(paper spock),
      %w(spock rock)
    ]
  end

  def pick_a_winner
    if winning_conditions.include? [player_choice, computer_choice]
      output("PLAYER WINS! #{player_choice} > #{computer_choice}")
    elsif player_choice == computer_choice
      output("You tied #{player_choice} == #{computer_choice}")
    else
      output("COMPUTER WINS! #{computer_choice} > #{player_choice}")
    end
  end

  def ask_for_rematch
    output("Want to play again (y)?")
    desire = ""
    threads = []
    threads << Thread.new do
      begin
        Timeout::timeout(3) do
          desire = gets.chomp.downcase
        end
      rescue Timeout::Error
        desire = "n"
      end
    end
    threads << Thread.new do
      num = 3
      until num == 0
        sleep(1)
        system("say '#{num} ...'")
        num -= 1
      end
    end
    threads.each { |thr| thr.join }
    if desire == "y"
      self.starter = false
      play
    else
      exit
    end
  end

  def output(thing)
    if test_mode
      thing
    else
      puts thing
    end
  end

end

# ~> LoadError
# ~> cannot load such file -- /Users/brentmwatson/documents/TheIronYard/w3d3-war/die
# ~>
# ~> /Users/brentmwatson/documents/TheIronYard/w3d3-war/class_notes.rb:29:in `require_relative'
# ~> /Users/brentmwatson/documents/TheIronYard/w3d3-war/class_notes.rb:29:in `<main>'
