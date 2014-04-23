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
  end
end
