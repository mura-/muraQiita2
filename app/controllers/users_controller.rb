class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_follow = current_user.user_follows.find_by(follow_user: params[:id])
  end
end
