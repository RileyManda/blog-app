class Api::V1::PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
    render json: { success: true, data: @posts }, include: %w[comments]
  end
end
