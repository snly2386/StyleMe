require 'yaml'
require 'active_record'
require 'pry-debugger'

module StyleMe
  module Databases

    class User < ActiveRecord::Base
      has_one :closet
    end

    class Closet < ActiveRecord::Base
      belongs_to :user
      has_many :photobooths
    end

    class Photobooth < ActiveRecord::Base
      belongs_to :photo
      has_many :results
    end

    class Photo <ActiveRecord::Base
      has_one :photobooth
    end

    class Result < ActiveRecord::Base
      belongs_to :photobooth
    end

    class SQLiteDatabase
      def initialize(env)

        config = YAML.load_file('db/config.yml')[env]
        # puts "HERE IS THE CONFIG"
        # puts config
        ActiveRecord::Base.establish_connection(
          # :adapter => 'sqlite3',
          # :database => 'styleme_test'
          YAML.load_file('db/config.yml')[env]
        )
      end

      def clear_everything
        Session.destroy_all
        User.destroy_all
        Closet.destroy_all
        Photobooth.destroy_all
        Photo.destroy_all
        Result.destroy_all
      end

      class Session < ActiveRecord::Base
        has_one :user
      end

      class User < ActiveRecord::Base
        has_one :closet
        before_save { self.email = email.downcase }
        validates :name, presence: true

        VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
        validates :password, length: {minimum: 6}
        has_secure_password
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
            # binding.pry
            ar_user = User.create(attrs)
            StyleMe::User.new(ar_user.attributes)
          end

          def get_user(id)
            id = id.to_i
            user = StyleMe::User.new(User.find(id).attributes)
          end

          def get_user_by_username(username)
            ar_user = User.where(:username =>username).first
            # binding.pry
            return nil if ar_user.nil?

            StyleMe::User.new(ar_user.attributes)
          end

          def create_session(attrs)
            ar_session = Session.create(attrs)
            StyleMe::Session.new(ar_session.attributes)
          end

          def get_session(id)
            session = StyleMe::Session.new(Session.find(id).attributes)
          end

          def get_session_by_user_id(user_id)
            ar_session = Session.where(:user_id => user_id).first
            StyleMe::Session.new(ar_session.attributes)
          end

          def create_closet(attrs)
            ar_closet = Closet.create(attrs)
            StyleMe::Closet.new(ar_closet.attributes)
          end

          def get_closet(id)
            closet = StyleMe::Closet.new(Closet.find(id).attributes)
          end

          def create_photo(attrs)
            ar_photo = Photo.create(attrs)
            StyleMe::Photo.new(ar_photo.attributes)
          end

          def get_photo(id)
            photo = StyleMe::Photo.new(Photo.find(id).attributes)
          end

          def create_photobooth(attrs)
            ar_photobooth = Photobooth.create(attrs)
            StyleMe::Photobooth.new(ar_photobooth.attributes)
          end

          def get_photobooth(id)
            photobooth = StyleMe::Photobooth.new(Photobooth.find(id).attributes)
          end

          def create_result(attrs)
            ar_result = Result.create(attrs)
            StyleMe::Result.new(ar_result.attributes)
          end
    end
  end
end
