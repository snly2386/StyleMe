module RabbitDice
  class Die < Entity
    attr_accessor :color, :type, :score, :wound

    def initialize(attrs={})
      super(attrs)
      @score = (@type == 'meat') ? 1 : 0
      @wound = (@type == 'blast') ? 1 : 0
    end

  end
end
