module RabbitDice
  class PlayMove < UseCase
    def run(params)
      game = RabbitDice.db.get_game(params[:game_id])
      return failure :invalid_game_id if game.nil?
      return failure :invalid_move unless params[:move].match /^roll_dice|stop$/

      current_turn = game.turns.last
      # TODO: Remove dice from dice cup as turn requires
      roll = game.dice_cup.roll
      current_turn.rolls.push(roll)

      success :game => game
    end
  end
end
