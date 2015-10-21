class Tip < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  has_many :comments
  has_many :stocks, dependent: :destroy
  validates :title, presence: true
  validates :content, presence: true

  default_scope ->{order(created_at: :desc).includes(:tags)}

  scope :followed_tags_with, ->(user) {
    tag_ids = user.tag_follows.pluck(:tag_id)
    tags = Tag.where(id: tag_ids).pluck(:name)
    Tip.tagged_with(tags, any: :true).order(created_at: :desc)
  }

  scope :followed_users_with, ->(user) {
    user_ids = user.user_follows.pluck(:follow_user)
    Tip.where(user_id: user_ids).order(created_at: :desc)
  }
  
  scope :stocked, ->(user) {
    tip_ids = user.stocks.pluck(:tip_id)
    Tip.where(id: tip_ids)
  }

end
