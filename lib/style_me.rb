require 'dotenv'
Dotenv.load

require 'ostruct'
require 'amazon/ecs'

puts "KEYS:"
puts ENV['AWS_SECRET_ACCESS_KEY']
puts ENV['AWS_ACCESS_KEY_ID']

require_relative 'style_me/databases/SQLitedb.rb'
require_relative 'style_me/databases/in_memory.rb'
# Gem.find_files("style_me/databases/*.rb").each { |path| require path }

require_relative 'style_me/entity.rb'
require_relative 'style_me/entities/closet.rb'
require_relative 'style_me/entities/result.rb'
require_relative 'style_me/entities/photo.rb'
require_relative 'style_me/entities/photobooth.rb'
require_relative 'style_me/entities/user.rb'
require_relative 'style_me/entities/session.rb'


require_relative 'style_me/use_case.rb'
require_relative 'style_me/use_cases/sign_up.rb'
require_relative 'style_me/use_cases/sign_in.rb'
require_relative 'style_me/use_cases/upload_photo.rb'
require_relative 'style_me/use_cases/create_photobooth.rb'
require_relative 'style_me/use_cases/load_photo_booth.rb'

module StyleMe
  # def self.db
  #   puts "hello"
  #   @__db_instance ||= Databases::SQLiteDatabase.new
  # end

  def self.db
    @db_class ||= Databases::PostGres
    @__db_instance ||= @db_class.new(@env || 'test')
  end

  def self.db_class=(db_class)
    @db_class = db_class
  end

  def self.env=(env_name)
    @env = env_name
  end

  def self.db_seed
    self.db.clear_everything
    user1 = self.db.create_user(username: "wendy", name: "wen", age: 24, about_me: "bleh", gender: "female", password: "123456",  email: "wndyhsu@gmail.com")
    user2 = self.db.create_user(username: "lola", name: "Lulu Wizeman", age: 24, about_me: "likes green beans", gender: "female", password: "123gree", email: "snly2386@gmail.com")
  end
end

class Array
  def sum_attr(attribute)
    self.map {|elem| elem.send(attribute) }.reduce(0, :+)
  end
end
