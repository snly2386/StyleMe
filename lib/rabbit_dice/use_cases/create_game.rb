module RabbitDice
  class CreateGame < UseCase
    def run(params)
      players = params[:players]

      if validate_players(players) == false
        return failure :invalid_players
      end

      game = RabbitDice.db.create_game(:players => players)

      success :game => game
    end

    def validate_players(players)
      players.is_a?(Array) && players.count >= 2 && players.all? {|name| name.length > 0 }
    end
  end
end