class ClosetsController < ApplicationController
  def new

  end

  def show
    @closet = Closet.find(params[:id])
  end
end
