class Tag < ActiveRecord::Base
  has_many :tag_follows
end
