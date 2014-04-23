module RabbitDice
  class Turn < Entity
    attr_accessor :game_id, :rolls, :player

    def initialize(attrs={})
      @rolls = []
      super(attrs)
    end
  end
end
