# app/controllers/admin_controller.rb
class AdminController < ApplicationController
  before_action :users

  # GET /user/admin
  def show
    render 'show'
  end

  private

  def users
    @users = User.all
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: projects_path, flash: { error: 'User was not found.' })
  end
end