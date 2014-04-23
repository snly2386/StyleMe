module RabbitDice
  class PlayMove < UseCase
    def run(params)
      game = RabbitDice.db.get_game(params[:game_id])
      return failure :invalid_game_id if game.nil?
      return failure :invalid_move unless params[:move].match /^roll_dice|stop$/
    end
  end
end
