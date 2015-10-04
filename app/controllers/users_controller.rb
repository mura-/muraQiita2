class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_follow = current_user.user_follows.find_by(follow_user: params[:id])
  end

  def mypage
    @my_tips = current_user.tips
    @stocked_tips = Tip.stocked(current_user)
  end
end
