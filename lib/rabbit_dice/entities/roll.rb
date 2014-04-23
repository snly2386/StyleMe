module RabbitDice
  class Roll < Entity
    attr_reader :results

    def initialize(attrs={})
      @dice = attrs[:dice]
      @results = @dice.map do |dice_color|
        type = dice_results[dice_color].sample
        Die.new :type => type, :color => dice_color
      end
    end

    private

    def dice_results
      {
        'green'  => %w{meat meat meat paws paws blast},
        'yellow' => %w{meat meat paws paws blast blast},
        'red'    => %w{meat paws paws blast blast blast}
      }
    end

  end
end
