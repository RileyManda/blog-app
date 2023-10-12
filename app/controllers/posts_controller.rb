class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @posts = Post.all
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post = @user.posts.includes(comments: :user).find(params[:id])
    @comments = @post.comments
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.new(
      title: params[:post][:title],
      text: params[:post][:text],
      comments_counter: 0,
      likes_counter: 0
    )

    if @post.save
      flash[:success] = 'Post created successfully!'
      redirect_to user_posts_path(@user)
    else
      flash[:error] = 'Error creating the post.'
      render 'new'
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
