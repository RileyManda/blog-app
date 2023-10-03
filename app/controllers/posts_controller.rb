class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
   end
end
