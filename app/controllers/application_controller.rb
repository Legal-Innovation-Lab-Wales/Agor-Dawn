# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def authorize_admin
    redirect_to root_path, flash: { error: 'You do not have access to this page '} unless current_user.admin
  end

  def configure_permitted_parameters
    attributes = %i[first_name last_name password email password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: %i[attributes avatar bio])
  end
end
