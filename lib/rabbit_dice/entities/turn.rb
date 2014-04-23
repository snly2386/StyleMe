module RabbitDice
  class Turn < Entity
    attr_accessor :game_id, :rolls, :player

    def initialize(attrs={})
      @rolls = []
      super(attrs)
    end

    def score
      # A score is the number of meat rolled
      @rolls.map {|roll| roll.score }.reduce(0, :+)
    end
  end
end
