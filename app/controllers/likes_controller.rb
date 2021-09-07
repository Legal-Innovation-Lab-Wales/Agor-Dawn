# app/controllers/likes_controller.rb
class LikesController < ApplicationController
  before_action :project

  # POST /projects/:project_id/likes
  def create
    Like.create!(user: current_user, project: @project)
  end

  # DELETE /projects/:project_id/likes
  def destroy
    @project.likes.where(user_id: current_user).first.destroy
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: projects_path, flash: { error: 'We encountered an error. Please try again.' })
  end

  private

  def project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: projects_path, flash: { error: 'Project was not found.' })
  end
end
