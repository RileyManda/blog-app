class PostsController < ApplicationController
  def index
    @posts = Post.all
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @comments = @post.comments
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created successfully!'
      redirect_to root_path
    else
      flash[:error] = 'Error creating the post.'
      render 'new'
    end
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
