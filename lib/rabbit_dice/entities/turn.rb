module RabbitDice
  class Turn < Entity
    attr_accessor :game_id, :rolls, :player

    def initialize(attrs={})
      @rolls = []
      super(attrs)
    end

    def score
      # A score is the number of meat rolled, UNLESS there are three wounds
      if wound_count >= 3
        0
      else
        @rolls.map {|roll| roll.score }.reduce(0, :+)
      end
    end

    def wound_count
      @rolls.map {|roll| roll.wounds }.reduce(0, :+)
    end
  end
end
