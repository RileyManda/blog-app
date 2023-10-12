class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :find_post

  def index
    @comments = @post.comments
    respond_to do |format|
      format.html
      format.json { render json: @comments }
    end
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to user_post_path(@comment.post.author_id, @comment.post.id) }
        format.json { render json: @comment, status: :created }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = Comment.new
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = 'Comment deleted successfully!'
    else
      flash[:error] = 'Error deleting the comment.'
    end
    redirect_to @comment.post
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
