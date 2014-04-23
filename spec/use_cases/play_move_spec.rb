require 'spec_helper'

describe RabbitDice::PlayMove do
  let(:game) { RabbitDice.db.create_game :players => ['Alice', 'Bob'] }
  let(:result) { described_class.run(@params) }

  before do
    @params = {
      :game_id => game.id,
      :move => 'roll_dice'
    }
  end

  describe "Error handling" do
    it "ensures the game exists" do
      @params[:game_id] = 12345
      expect(result.success?).to eq false
      expect(result.error).to eq :invalid_game_id
    end

    it "ensures the move is valid" do
      @params[:move] = 'instawin'
      expect(result.success?).to eq false
      expect(result.error).to eq :invalid_move
    end
  end
end
