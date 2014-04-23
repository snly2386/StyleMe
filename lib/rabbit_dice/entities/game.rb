module RabbitDice
  # Now the rest of our modules get that initialize method for free
  class Game < Entity
    # ...as long as we have an attr, we can set it using that style
    attr_accessor :id, :players, :winner, :turns, :dice_cup

    def initialize(attrs={})
      @turns = []
      super(attrs)
    end

    def score_for(player)
      @turns.select {|turn| turn.player == player}.sum_attr(:score)
    end

    def end_turn
      current_player = @turns.last.player
      current_player_index = @players.index(current_player)
      next_player = @players[(current_player_index + 1) % @players.length]

      turn = Turn.new :game_id => self.id, :player => next_player
      @turns.push(turn)
    end
  end
end
