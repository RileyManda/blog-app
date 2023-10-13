class Api::V1::PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:likes, :comments)

    render json: @posts, each_serializer: PostSerializer
  end
end
