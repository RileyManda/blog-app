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
  @post.comments_counter = 0
  @post.likes_counter = 0

  if @post.save
    flash[:success] = 'Post created successfully!'
    redirect_to user_posts_path(@user)
  else
    flash[:error] = 'Error creating the post.'
    puts @post.errors.full_messages # Log validation errors
    render 'new'
  end
end



  def post_params
    params.require(:post).permit(:title, :text)
  end
end
