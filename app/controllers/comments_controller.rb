class CommentsController < ApplicationController
  before_action :find_post

  def create
  @comment = @post.comments.build(comment_params)
  @comment.user = current_user

  if @comment.save
    flash[:success] = 'Comment created successfully!'
  else
    flash[:error] = 'Error creating the comment.'
  end

  redirect_to user_post_path(@post.author, @post)
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
