class Tip < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  has_many :comments
  has_many :stocks, dependent: :destroy
  validates :title, presence: true
  validates :content, presence: true
end
