# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :user

  # GET /user/:id
  def show
    stats

    render 'show'
  end

  private

  def stats
    @comments_posted = @user.comments.count
    @likes_posted = @user.likes.count
    @comments_received = 0
    @likes_received = 0
    @user.projects.each do |project|
      if project.user_id == @user.id
        @comments_received += project.comments.count
        @likes_received += project.likes.count
      end
    end
  end

  def user
    @user = User.includes(:projects, :comments).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: projects_path, flash: { error: 'User was not found.' })
  end
end