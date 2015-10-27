class TagsController < ApplicationController
  skip_before_action :authenticate_user!
  def show
    @tag = Tag.find(params[:id])
    @tips = Tip.page(params[:page]).tagged_with([@tag.name], any: :true)
    ### current_user が tag をフォローしているかどうかの判断は、User モデルの責務にした方がよいと思いました.
    ### User#following?(tag) のようなメソッドを定義して、view 側で呼び出せば、コードもより DRY になります.
    if user_signed_in?
      @tag_follow = current_user.tag_follows.find_by(tag_id: params[:id])
    end
  end
end
