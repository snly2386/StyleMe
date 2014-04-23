require 'spec_helper'

describe RabbitDice::Databases::InMemory do
  let(:db) { RabbitDice.db }

  it "create a game" do
    game = db.create_game :players => ['Alice', 'Bob', 'Carl']

    expect(game.players).to include('Alice', 'Bob', 'Carl')
    expect(game.winner).to be_nil

    expect(game.turns.count).to eq 1
    expect(game.turns.first.player).to match /^Alice|Bob|Carl$/
    expect(game.turns.first.rolls.count).to eq 0
  end

  it "gets a game"
end
