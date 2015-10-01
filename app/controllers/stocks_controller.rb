class StocksController < ApplicationController
  include NotificationHandlers

  def create
    stock = current_user.stocks.new(stock_params)
    if stock.save
      flash.notice = 'ストックしました。'
      notify_stocks(stock)    
    else
      flash.notice = 'ストックできませんでした。時間をおいてお試しください。'
    end
    redirect_to tip_path(stock_params[:tip_id])
  end

  def destroy
    stock = current_user.stocks.find(params[:id])
    if stock.destroy
      flash.notice = 'ストックを取り消しました。'
    else
      flash.notice = '取り消せませんでした。時間をおいてお試しください。'
    end
    redirect_to tip_path(stock.tip_id)
  end

  private
  def stock_params
    params.require(:stock).permit(:user_id, :tip_id)
  end
end
