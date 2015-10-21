class TipsController < ApplicationController
  before_action :set_tip, only: [:show]
  skip_before_action :authenticate_user!, only: [:index, :show, :find_by_tags]
  include NotificationHandlers

  def index
    @tips = Tip.page(params[:page]).order(created_at: :desc)
  end

  def show
    @comments = @tip.comments
    @comment_form = Comment.new
    if user_signed_in?
      @stock = current_user.stocks.find_by(tip_id: @tip)
    end
  end

  def edit
    # FIXME: DRYにかけないか？
    @tip = current_user.tips.find(params[:id])
  end

  def new
    @tip = current_user.tips.new
  end

  def create
    @tip = current_user.tips.new(tip_params)
    if @tip.save
      flash.notice = '記事を作成しました。'
      redirect_to @tip
    else
      render :new
    end
  end

  def update
    @tip = current_user.tips.find(params[:id])
    if @tip.blank?
      flash.alert = '他ユーザーの記事は変更できません。'
      redirect_to tip_url and return
    end
    if @tip.update(tip_params)
      flash.notice = '記事を更新しました。'
      notify_tip_update(@tip)
      redirect_to @tip
    else
      render :edit
    end
  end

  def destroy
    @tip = current_user.tips.find(params[:id])
    if @tip.blank?
      flash.alert = '他ユーザーの記事は変更できません。'
      redirect_to tip_url and return
    end
    @tip.destroy
    redirect_to tips_url
  end

  def mine
    @tips = current_user.tips.page(params[:page])
  end

  def stocked
    @tips = Tip.page(params[:page]).stocked(current_user)
  end

  def followed_tags_with
    @tips = Tip.page(params[:page]).followed_tags_with(current_user)
  end

  def followed_users_with
    @tips = Tip.page(params[:page]).followed_users_with(current_user)
  end

  def feed
    tips = Tip.followed_tags_with(current_user) | Tip.followed_users_with(current_user)
    # ActiveRecord::Rlation型に変換して格納する(ScopeでORの組み合わせをすると配列しか帰ってこなかった)
    @tips = Tip.page(params[:page]).where(id: tips.map{ |tip| tip.id })
  end

  private
  def set_tip
    @tip = Tip.find(params[:id])
  end

  def tip_params
    params.require(:tip).permit(:title, :content, :tag_list)
  end

end
