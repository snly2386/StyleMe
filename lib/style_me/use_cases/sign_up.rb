module StyleMe
  class SignUp < UseCase
    def run(params)
      @db = StyleMe.db

      username = params[:username]
      return failure(:username_taken) if @db.get_user_by_username(username) != nil

      password = params[:password]
      return failure(:invalid_password) if password.length < 6

      # user = @db.create_user(:username => params[:username], :name => params[:name], :age => params[:age], :gender => params[:gender], :about_me => params[:about_me], :password => password, :password_digest =>password_digest)

      user = @db.create_user(params)

      # binding.pry
      success :user => user
    end
  end
end




