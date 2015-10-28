class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  def show
    @user = User.find(params[:id])
    @tips = @user.tips.page(params[:page])
    ### current_user が @user をフォローしているかどうかの判断は、User モデルの責務にした方がよいと思いました.
    ### User#followed? のようなメソッドを定義して、view 側で呼び出せば、コードもより DRY になります.
    @user_follow = current_user.user_follows.find_by(follow_user: params[:id]) if user_signed_in?
  end

  def mypage
    ### インスタンス変数が多いですね
    ### current_user から引けるものは、controller 側でインスタンス変数に入れるのではなく view で記述した方がよいと思いました.
    ### @stocked_tips, @followed_users, @comments あたりも モデルにロジックを書けば current_user から引けそうな気がします.
    @my_tips = current_user.tips.limit(5)
    @stocked_tips = Tip.stocked(current_user).limit(5)
    @followed_tags = current_user.tags
    @follow_users = current_user.follow_users
    @followed_users = User.followed_users(current_user)
    @comments = Comment.where(tip_id: @my_tips.pluck(:id)).limit(5)
  end
end
