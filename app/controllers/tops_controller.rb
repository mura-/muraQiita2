class TopsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    if user_signed_in?
      redirect_to feed_tips_url
    end
  end
end
