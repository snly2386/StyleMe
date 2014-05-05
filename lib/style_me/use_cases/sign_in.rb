module StyleMe
  class SignIn < UseCase
    def run(params)
     @db = StyleMe.db
     user = @db.get_user_by_username(params[:username])
    
     username = params[:username]

     return failure(:no_user_exists) if user == nil

     return failure(:invalid_username) if username!= user.username
     
     password = params[:password]
     return failure(:invalid_password) if password != user.password


     closet = user.closet

     success :user => user, :closet => closet 
    end
  end
end
