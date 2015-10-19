class UserFollowsController < ApplicationController
  def create
    follow_user = User.find(params[:user_id])
    user_follow = current_user.user_follows.new(follow_user: follow_user)  
    if user_follow.save
      flash.notice = 'ユーザーをフォローしました。'
    else
      flash.alert = 'ユーザーをフォローできませんでした。もう一度お試しください。'
    end
    redirect_to user_path(params[:user_id])
  end

  def destroy
    user_follow = current_user.user_follows.find_by(follow_user: params[:user_id])  
    if user_follow.destroy
      flash.notice = 'ユーザーをアンフォローしました。'
    else
      flash.alert = 'ユーザーをアンフォローできませんでした。もう一度お試しください。'
    end
    redirect_to user_path(params[:user_id])
  end

end
