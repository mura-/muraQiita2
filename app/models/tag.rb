class Tag < ActiveRecord::Base
  has_many :tag_follows

  ### テーブルの構造上 `name` に null を許容しないのであれば、モデルにもその validation があるべきですね
  ### 例えば `validates :name, presence: true`
end
