# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :require_approval

  protected

  def configure_permitted_parameters
    attributes = [:first_name, :last_name, :password, :email, :password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: %i[attributes avatar bio])
  end

  def require_approval
    return unless current_user && !current_user.approved?
    sign_out_and_redirect(current_user)
    flash[:error] = "You require approval from an admin before you can sign in."
  end
end
