module RabbitDice
  module Databases
    class InMemory

      def create_game(attrs)
        game = Game.new(:players => attrs[:players])

        starting_player = game.players.sample
        starting_turn = Turn.new(:game_id => game.id, :player => starting_player)
        game.turns.push(starting_turn)
        game
      end

    end
  end
end