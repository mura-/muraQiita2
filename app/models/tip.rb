class Tip < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  has_many :comments
  validates :title, presence: true
  validates :content, presence: true
end
