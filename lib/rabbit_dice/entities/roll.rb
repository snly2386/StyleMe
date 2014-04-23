module RabbitDice
  class Roll < Entity
    attr_reader :results

    def initialize(attrs={})
      @dice = attrs[:dice]
      @results = @dice.map do |dice_color|
        # For testing, we need to ensure the result is always meat.
        # To make this easier, we wrap this in a method
        type = roll_die(dice_color)
        Die.new :type => type, :color => dice_color
      end
    end

    def score
      # Count up the number of meats!
      @results.map {|die| die.score }.reduce(0, :+)
    end

    def wounds
      @results.map {|die| die.wound }.reduce(0, :+)
    end

    private

    def roll_die(color)
      dice_results[color].sample
    end

    def dice_results
      {
        'green'  => %w{meat meat meat paws paws blast},
        'yellow' => %w{meat meat paws paws blast blast},
        'red'    => %w{meat paws paws blast blast blast}
      }
    end

  end
end
