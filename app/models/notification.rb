class Notification < ActiveRecord::Base
  belongs_to :user
  ### 読んだかどうかを表現するカラムであれば、
  ### is_checked よりも read と命名した方がわかりやすいと思いました
  scope :unreads, -> { where(is_checked: false)}

  ### テーブルの構造上 `content` に null を許容しないのであれば、モデルにもその validation があるべきですね
  ### 例えば `validates :content, presence: true`
end
