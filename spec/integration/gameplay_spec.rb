require 'spec_helper'

describe 'Gameplay' do
  let(:game) { RabbitDice.db.create_game :players => ['Alice', 'Bob', 'Carl'] }

  def play_move(move)
    result = RabbitDice::PlayMove.run(:game_id => game.id, :move => move)
    result.game
  end

  def count_die_color(dice_cup, die_color)
    dice_cup.instance_variable_get(:@dice).select {|color| color == die_color }.count
  end

  before do
    game.turns.first.player = 'Alice'
  end

  it "removes dice from the dice cup after multiple plays" do
    # In order for the dice count to reduce by 3 every time,
    # we need to ensure there are no paws (runners)
    RabbitDice::Roll.any_instance.stub(:roll_die).and_return('meat')

    expect(game.dice_cup.dice_count).to eq 13
    game = play_move('roll_dice')
    expect(game.dice_cup.dice_count).to eq 10
    game = play_move('roll_dice')
    expect(game.dice_cup.dice_count).to eq 7
  end

  it "creates a roll with the correct dice" do
    RabbitDice::Roll.any_instance.stub(:roll_die).and_return('meat')

    expect(game.dice_cup.dice_count).to eq 13
    game = play_move('roll_dice')
    expect(game.dice_cup.dice_count).to eq 10

    roll = game.turns.last.rolls.last
    expect(roll.results.first).to be_a RabbitDice::Die
    expect(roll.results.map &:type).to eq ['meat', 'meat', 'meat']
  end

  it "calculates score" do
    RabbitDice::Roll.any_instance.stub(:roll_die).and_return('meat')

    play_move('roll_dice')
    game = play_move('roll_dice')
    expect(game.score_for 'Alice').to eq(6)
    expect(game.score_for 'Bob').to eq(0)
    expect(game.score_for 'Carl').to eq(0)
  end

  describe 'Overblasting' do

    before do
      # First give them some points
      RabbitDice::Roll.any_instance.stub(:roll_die).and_return('meat')
      game = play_move('roll_dice')
      expect(game.score_for 'Alice').to eq(3)

      # Now really give it to 'em!
      RabbitDice::Roll.any_instance.stub(:roll_die).and_return('blast')
      game = play_move('roll_dice')
    end

    it "does not score when the player rolls three blasts" do
      expect(game.score_for 'Alice').to eq(0)
    end

    it "creates the next player's turn when the current player rolls three blasts" do
      expect(game.turns.count).to eq(2)
      expect(game.turns.last.player).to eq 'Bob'
    end
  end

  it "ends the turn if the current player chooses to do so" do
    # First give them some points
    RabbitDice::Roll.any_instance.stub(:roll_die).and_return('meat')
    game = play_move('roll_dice')
    expect(game.score_for 'Alice').to eq(3)

    # Now end the turn
    game = play_move('stop')
    expect(game.turns.count).to eq(2)
    expect(game.turns.last.player).to eq 'Bob'

    # Double check score
    expect(game.score_for 'Alice').to eq(3)
    expect(game.turns.first.score).to eq(3)
  end

  it "declares a winner once someone gets 13 meat" do
    # To make things interesting, let's pass the turn to Carl
    2.times { play_move('stop') }

    # Win that game
    RabbitDice::Roll.any_instance.stub(:roll_die).and_return('meat')
    # 3meat x 4 = 12meat
    4.times { play_move('roll_dice') }
    # 12 + 3 = 15
    game = play_move('roll_dice')
    expect(game.winner).to eq 'Carl'
  end

  it "ends the turn when there are no more dice left to draw"

  it "subtracts less dice from the cup when there are paws (runners)" do
    RabbitDice::Roll.any_instance.stub(:roll_die).and_return('paws')
    game = play_move('roll_dice')

    expect(game.dice_cup.dice_count).to eq 10

    game = play_move('roll_dice')
    # Since all three dice were runners, we shouldn't need to draw more dice
    expect(game.dice_cup.dice_count).to eq 10

    # Modify the last roll results to contain 2 paws instead of 3
    die = game.turns.last.rolls.last.results.last
    die.type = 'meat'

    game = play_move('roll_dice')
    expect(game.dice_cup.dice_count).to eq 9
  end
end
