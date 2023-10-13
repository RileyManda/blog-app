class Api::V1::CommentsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comments = @post.comments.includes(:user)
    render json: { success: true, data: @comments }, include: %w[user]
  end

  def create
    @comment = current_user.comments.build(comments_params)
    if @comment.save
      render json: { success: true, data: @comment }, status: :created
    else
      render json: { error: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:text).merge(post_id: params[:post_id])
  end
end
