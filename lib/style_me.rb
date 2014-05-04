require 'ostruct'

require_relative 'style_me/databases/in_memory.rb'

require_relative 'style_me/entity.rb'
require_relative 'style_me/entities/closet.rb'
require_relative 'style_me/entities/result.rb'
require_relative 'style_me/entities/photo.rb'
require_relative 'style_me/entities/photobooth.rb'
require_relative 'style_me/entities/user.rb'

require_relative 'style_me/use_case.rb'
require_relative 'style_me/use_cases/sign_up.rb'
require_relative 'style_me/use_cases/sign_in.rb'
require_relative 'style_me/use_cases/upload_photo.rb'
require_relative 'style_me/use_cases/create_photobooth.rb'

module StyleMe
  def self.db
    @__db_instance ||= Databases::InMemory.new
  end
end

class Array
  def sum_attr(attribute)
    self.map {|elem| elem.send(attribute) }.reduce(0, :+)
  end
end
