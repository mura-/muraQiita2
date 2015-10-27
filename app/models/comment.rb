class Comment < ActiveRecord::Base
  belongs_to :tip
  belongs_to :user

  ### テーブルの構造上 `content` に null を許容しないのであれば、モデルにもその validation があるべきですね
  ### 例えば `validates :content, presence: true`
end
