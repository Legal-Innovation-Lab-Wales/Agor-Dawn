# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :user

  # GET /user/:id
  def show
    render 'show'
  end

  private

  def user
    @user = User.includes(:projects).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: projects_path, flash: { error: 'User was not found.' })
  end
end
