class PhotoboothsController < ApplicationController
  def create
    result = StyleMe::CreatePhotoBooth.run(:user_id => params[:user_id], :image_file => params[:image_file])
    @result = result.results
    @user = result.user
    @photo - result.photo
    if result.success?
      redirect_to "/users/#{@user.id}/photos/#{@photo.id}/photobooths"
    else 
      @error = result.error
    end
  end
end
