require 'spec_helper'

describe RabbitDice::Databases::InMemory do
  let(:db) { RabbitDice.db }

  it "create a game" do
    game = db.create_game :players => ['Alice', 'Bob', 'Carl']

    expect(game.players).to include('Alice', 'Bob', 'Carl')
    expect(game.winner).to be_nil
    expect(game.dice_cup).to be_a RabbitDice::DiceCup

    expect(game.turns.count).to eq 1
    expect(game.turns.first.player).to match /^Alice|Bob|Carl$/
    expect(game.turns.first.rolls.count).to eq 0
  end

  it "gets a game" do
    created_game = db.create_game :players => ['Dan', 'Earl', 'Fred']
    game = db.get_game(created_game.id)

    # I'm repeating myself, but that's ok if it's one test. maybe
    expect(game.players).to include('Dan', 'Earl', 'Fred')
    expect(game.winner).to be_nil
    expect(game.dice_cup).to be_a RabbitDice::DiceCup

    expect(game.turns.count).to eq 1
    expect(game.turns.first.player).to match /^Dan|Earl|Fred$/
    expect(game.turns.first.rolls.count).to eq 0
  end
end
