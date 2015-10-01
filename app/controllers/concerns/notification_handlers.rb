module NotificationHandlers
  extend ActiveSupport::Concern

  def notify_comments(comment)
    notification = Notification.new(
      user_id: comment.tip.user_id,
      content: '新着のコメントがあります',
      reference_url: tip_url(comment.tip_id)
    )
    notification.save
  end

  def notify_stocks(stock)
    notification = Notification.new(
      user_id: stock.tip.user_id,
      content: 'あなたの投稿がストックされました',
      reference_url: tip_url(stock.tip_id)
    )
    notification.save
  end

  def notify_tip_update(tip)
    notifications = []
    content = 'あなたがストックした記事が更新されました'
    reference_url = tip_url(tip)
    tip.stocks.each do |stock|
      notifications << Notification.new(
        user_id: stock.user_id,
        content: content, 
        reference_url: reference_url)
    end
    Notification.import(notifications)
  end

end
