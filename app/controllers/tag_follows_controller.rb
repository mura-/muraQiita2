class TagFollowsController < ApplicationController
  def create 
    tag_follow = current_user.tag_follows.new(tag_id: params[:tag_id])
    if tag_follow.save
      flash.notice = 'タグをフォローしました。'
    else
      flash.alert = 'タグをフォローできませんでした。もう一度お試しください。'
    end
    redirect_to tag_path(params[:tag_id])
  end

  def destroy
    tag_follow = current_user.tag_follows.find_by(tag_id: params[:tag_id])
    if tag_follow.destroy
      flash.notice = 'タグをアンフォローしました。'
    else
      flash.alert = 'タグをアンフォローできませんでした。もう一度お試しください。'
    end
    redirect_to tag_path(params[:tag_id])
  end
end
