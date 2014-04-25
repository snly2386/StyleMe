module RabbitDice
  class PlayMove < UseCase
    def run(params)
      @game = RabbitDice.db.get_game(params[:game_id])

      return failure :invalid_game_id if @game.nil?
      return failure :game_over unless @game.winner == nil
      return failure :invalid_move unless params[:move].match /^roll_dice|stop$/

      if params[:move] == 'roll_dice'
        current_turn = @game.turns.last
        previous_roll = current_turn.rolls.last

        roll = @game.dice_cup.roll(previous_roll)
        current_turn.rolls.push(roll)

        if current_turn.over? || @game.dice_cup.empty?
          @game.end_turn unless someone_won
        end
      elsif params[:move] == 'stop'
        @game.end_turn
      end

      @game.winner = @game.current_player if someone_won

      success :game => @game
    end

    def someone_won
      @game.score_for(@game.current_player) >= 13
    end
  end
end
