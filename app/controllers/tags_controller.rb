class TagsController < ApplicationController
  skip_before_action :authenticate_user!
  def show
    @tag = Tag.find(params[:id])
    if user_signed_in?
      @tag_follow = current_user.tag_follows.find_by(tag_id: params[:id])
    end
  end
end
