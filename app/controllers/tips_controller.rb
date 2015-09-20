class TipsController < ApplicationController
  before_action :set_tip, only: [:show]

  def index
    @tips = Tip.order(created_at: :desc)
  end

  def show
    @comments = @tip.comments
    @comment = @tip.comments.build
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
    @tips = current_user.tips
  end

  private
  def set_tip
    @tip = Tip.find(params[:id])
  end

  def tip_params
    params.require(:tip).permit(:title, :content)
  end

end
