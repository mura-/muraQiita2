class User < ActiveRecord::Base
  has_many :comments
  has_many :stocks, dependent: :destroy
  has_many :tips
  has_many :user_follows
  has_many :tag_follows
  has_many :tags, through: :tag_follows
  has_many :follow_users, through: :user_follows, class_name: 'User', source: :follow_user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable, omniauth_providers: [:twitter]

  def self.from_omniauth(auth)
    where(provider: auth["provider"], uid: auth["uid"]).first_or_create do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["nickname"]
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
          user.attributes = params
          user.valid?
      end
    else
      super
    end
  end
end
