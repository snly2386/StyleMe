
require_relative 'rabbit_dice/databases/in_memory.rb'

require_relative 'rabbit_dice/entity.rb'
require_relative 'rabbit_dice/entities/game.rb'
require_relative 'rabbit_dice/entities/turn.rb'

module RabbitDice
  def self.db
    @__db_instance ||= Databases::InMemory.new
  end
end
