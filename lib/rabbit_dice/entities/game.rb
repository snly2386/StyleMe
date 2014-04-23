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
      turns = @turns.select {|turn| turn.player == player}

      # This converts each turn into a number, then sums up those numbers
      turns.map {|turn| turn.score }.reduce(0, :+)
    end
  end
end
