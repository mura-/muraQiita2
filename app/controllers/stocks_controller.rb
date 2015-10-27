class StocksController < ApplicationController
  include NotificationHandlers

  ### ストックの処理は view 側で `remote: true` を使って Ajax で通信する実装の方が、
  ### コードがすっきりするかもしれません
  ### `remote: true` による処理については、トライアウトのコードレビュー動画の
  ###「10. link_to, form_for の remote: true オプションの実装パターン」
  ### に具体例があります.

  def create
    stock = current_user.stocks.new(stock_params)
    if stock.save
      flash.notice = 'ストックしました。'
      notify_stocks(stock)
    else
      ### エラーメッセージは可能な限り正確に表示した方が良いと思います.
      ### `stock.save` が失敗した場合は `stock.errors` に何がしかのエラーメッセージが保存
      ### されているはずですので、それを表示した方が、ユーザーにより正確な情報が伝わると思います.
      flash.notice = 'ストックできませんでした。時間をおいてお試しください。'
    end
    redirect_to tip_path(stock_params[:tip_id])
  end

  def destroy
    stock = current_user.stocks.find(params[:id])
    if stock.destroy
      flash.notice = 'ストックを取り消しました。'
    else
      ### 同上
      flash.notice = '取り消せませんでした。時間をおいてお試しください。'
    end
    redirect_to tip_path(stock.tip_id)
  end

  private
  def stock_params
    params.require(:stock).permit(:user_id, :tip_id)
  end
end
