# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :user

  # GET /user/:id
  def show
    comments_count

    render 'show'
  end

  private

  def comments_count
    @comments_count = @user.comments.all.count
  end

  def user
    @user = User.includes(:projects, :comments).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: projects_path, flash: { error: 'User was not found.' })
  end
end