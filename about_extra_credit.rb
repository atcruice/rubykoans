# EXTRA CREDIT:
#
# Create a program that will play the Greed Game.
# Rules for the game are in GREED_RULES.TXT.
#
# You already have a DiceSet class and score function you can use.
# Write a player class and a Game class to complete the project.  This
# is a free form assignment, so approach it however you desire.

require_relative 'about_dice_project'
require_relative 'about_scoring_project'
require 'faker'

# represents a game of Greed
class GreedGame
  IN_THRESHOLD = 300
  attr_reader :players

  def initialize(n_players)
    @dice = DiceSet.new
    @players = []
    [n_players.to_i, 2].max.times { uniq_player }
    @round, @last_round = 0, false
    puts self
    play_round until @last_round
    puts "Winner: #{@players.sort.first}\n"
  end

  def to_s
    output = @last_round ? "* Last Round *\n" : "* Round #{@round} *\n"
    @players.sort.each do |player|
      output << "#{player.name}: #{player.points}\n"
    end
    output << "\n"
  end

  private

  def uniq_player
    init_len = @players.length
    until @players.length > init_len
      name = Faker::Name.first_name
      @players << GreedPlayer.new(name) unless @players.reduce(false) do |a, e|
        # reduces to true if name already exists
        a || name == e.name
      end
    end
  end

  def play_round
    @round += 1
    @last_round ||= @players.reduce(false) { |a, e| a || e.points >= 3000 }
    @players.each { |player| player.take_turn(@dice) }
    puts self
  end

  # represents a single Greed player
  class GreedPlayer
    attr_reader :name
    attr_accessor :points, :in_game

    def initialize(name)
      @name, @points, @in_game = name, 0, false
    end

    def take_turn(dice)
      turn_score, roll_score = 0, 0
      n_dice = 5
      loop do
        dice.roll(n_dice)
        turn_score += roll_score = score(dice.values)
        # n_dice = non_scoring(dice.values) == 0 ? 5 : non_scoring(dice.values)
        break unless roll_score > 0 && (@in_game ||= roll_score >= IN_THRESHOLD) && roll_again?
      end
      turn_score = 0 if roll_score == 0 || !in_game
      @points += turn_score
    end

    def <=>(other)
      return -1 if points > other.points
      return 1 if points < other.points
      0
    end

    def to_s
      "#{name}: #{points}"
    end

    private

    def roll_again?
      # TODO: complete
      false
    end
  end
end

GreedGame.new(10)
