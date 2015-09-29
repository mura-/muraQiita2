class Stock < ActiveRecord::Base
  has_many :user
  has_many :tip
end
