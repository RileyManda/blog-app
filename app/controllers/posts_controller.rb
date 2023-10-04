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

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

def create
  @user = User.find(params[:user_id])
  @post = current_user.posts.build(post_params)
  if @post.save
    flash[:success] = 'Post created successfully!'
    redirect_to user_posts_path(@user) # Use @user 
  else
    flash[:error] = 'Error creating the post.'
    render 'new'
  end
end


  def post_params
    params.require(:post).permit(:title, :text)
  end
end
