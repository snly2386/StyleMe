module RabbitDice
  class Die < Entity
    attr_accessor :color, :type, :score, :wound

    def initialize(attrs={})
      super(attrs)
      @score = 1 if @type == 'meat'
      @wound = 1 if @type == 'blast'
    end

  end
end
