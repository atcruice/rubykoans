# EXTRA CREDIT:
#
# Create a program that will play the Greed Game.
# Rules for the game are in GREED_RULES.TXT.
#
# You already have a DiceSet class and score function you can use.
# Write a player class and a Game class to complete the project.  This
# is a free form assignment, so approach it however you desire.

require 'about_scoring_project'
require 'about_dice_project'
require 'faker'

# represents a Greed player
class Player
  attr_reader :name
  attr_accessor :score, :in

  def initialize(name)
    @name, @score, @in = name, 0, false
  end

  def roll_again?
    # TODO: complete
    false
  end
end

# represents a Greed game
class Game
  IN_THRESHOLD = 300
  attr_reader :players

  def initialize(n_players)
    @dice = DiceSet.new
    @players = Array.new([n_players.to_i, 2].max) { uniq_player }
    @round , @last_round, @game_over = 1, false, false

    play_round until winner?
  end

  private

  def uniq_player
    init_len = @players.length
    until @players.length > init_len
      name = Faker::Name.first_name
      @players << Player.new(name) unless @players.reduce(false) do |a, e|
        # returns true if name already present
        a || name == e.name
      end
    end
  end

  def play_round
    @players.each { |player| take_turn(player) }
    @round += 1
  end

  def winner?
  end

  def take_turn(player)
    turn_score = 0
    n_dice = 5
    begin
      roll = @dice.roll(n_dice)
      n_dice = @dice.non_scoring
    end while roll > 0 && (player.in ||= roll >= IN_THRESHOLD)
  end
end
