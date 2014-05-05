require 'yaml'
require 'active_record'
require 'pry-debugger'
# dbconfig = YAML::load(File.open('db/config.yml'))
# ActiveRecord::Base.establish_connection(dbconfig)
module StyleMe
  module Databases
  class SQLiteDatabase

  def initialize
    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database => 'styleme_test'
    )
  end
  # binding.pry
  def clear_everything
    User.destroy_all
    Closet.destroy_all
    Photobooth.destroy_all
    Photo.destroy_all
    Result.destroy_all
  end

  class User < ActiveRecord::Base
    has_one :closet
  end

  class Closet < ActiveRecord::Base
    belongs_to :user
    has_many :photobooths
  end

  class Photobooth < ActiveRecord::Base
    has_one :photo
    has_many :results
  end

  class Photo <ActiveRecord::Base
    belongs_to :photobooth
  end

  class Result < ActiveRecord::Base
    belongs_to :photobooth
  end

  #Database Methods
  def create_user(attrs)
    ar_user = User.create(attrs)
    StyleMe::User.new(ar_user.attributes)
  end

  def get_user(id)
    user = StyleMe::User.new(User.find(id).attributes)
    # user.closet = ...
    # user
  end

  def get_user_by_username(username)
    user = User.where(:username =>username)
  end

  def get_closet(id)
    closet = StyleMe::Closet.new(Closet.find(id).attributes)
  end

  def create_photo(attrs)
    # binding.pry
    ar_photo = Photo.create(attrs)
    StyleMe::Photo.new(ar_photo.attributes)

  end



    end
  end
end
