require 'spec_helper'

describe RabbitDice::CreateGame do
  let(:result) { described_class.run(:players => @players) }

  before do
    @players = ['Alice', 'Bob']
  end

  describe "Error handling" do
    it "ensures there is at least two players" do
      @players = ['Bob']
      expect(result.success?).to eq false
      expect(result.error).to eq :invalid_players
    end

    it "ensures each player name has at least one character" do
      @players = ['Alice', 'Bob', '']
      expect(result.success?).to eq false
      expect(result.error).to eq :invalid_players
    end
  end

  it "creates a game" do
    expect(result.success?).to eq true
    expect(result.game).to be_a RabbitDice::Game
  end
end
