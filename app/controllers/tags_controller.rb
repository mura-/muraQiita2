class TagsController < ApplicationController
  skip_before_action :authenticate_user!
  def show
    @tag = Tag.find(params[:id])
    @tips = Tip.page(params[:page]).tagged_with([@tag.name], any: :true)
    if user_signed_in?
      @tag_follow = current_user.tag_follows.find_by(tag_id: params[:id])
    end
  end
end
