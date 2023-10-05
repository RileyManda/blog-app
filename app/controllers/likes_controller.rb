class LikesController < ApplicationController
  before_action :set_post

  def create
    @like = @post.likes.build(user: current_user)

    if @like.save
      flash.now[:success] = 'Post liked successfully!'
    else
      flash.now[:error] = 'Error liking the post.'
    end

    respond_to do |format|
      format.html { redirect_to user_post_path(current_user, @post) }
      format.js
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    flash.now[:success] = 'Post unliked successfully.'

    respond_to do |format|
      format.html { redirect_to user_post_path(@like.post.user, @like.post) }
      format.js
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
