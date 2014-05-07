class PhotosController < ApplicationController
  def new
    @photo = Photo.new
  end

  def create
    photo = photo.new(user_params)
    photo.save
  end
end
