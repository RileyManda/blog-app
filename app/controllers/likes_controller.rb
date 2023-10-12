class LikesController < ApplicationController
  before_action :set_post

  def create
    @like = @post.likes.build(user: current_user)

    respond_to do |format|
      if @like.save
        flash.now[:success] = 'Post liked successfully!'
        format.html { redirect_to user_post_path(current_user, @post) }
        format.json { render json: @like, status: :created }
      else
        flash.now[:error] = 'Error liking the post.'
        format.html { redirect_to user_post_path(current_user, @post) }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @like = Like.find(params[:id])

    respond_to do |format|
      if @like.destroy
        flash.now[:success] = 'Post unliked successfully.'
        format.html { redirect_to user_post_path(@like.post.user, @like.post) }
        format.json { head :no_content }
      else
        flash.now[:error] = 'Error unliking the post.'
        format.html { redirect_to user_post_path(@like.post.user, @like.post) }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
