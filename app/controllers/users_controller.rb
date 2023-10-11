class UsersController < ApplicationController
  # load_and_authorize_resource
  def index
    @users = User.all
  end
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def show
    @user = User.find(params[:id])
    @user_posts = @user.posts.includes(:comments)
  end
end
