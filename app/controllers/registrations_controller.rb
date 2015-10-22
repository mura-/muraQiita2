class RegistrationsController < Devise::RegistrationsController

  before_action :configure_permitted_parameters, only: [:create, :update]

  private 
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:username,
        :email, :password, :password_confirmation, :current_password)
    end
  end  
 
end
