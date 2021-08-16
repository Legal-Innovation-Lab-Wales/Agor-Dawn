# app/controllers/likes_controller.rb
class LikesController < ApplicationController
  before_action :project

  # POST /projects/:project_id
  def create
    Like.create!(user: current_user, project: @project)

    redirect_to project_path(@project), flash: { success: 'Project was successfully liked.' }
  end

  # DELETE /projects/:project_id/like/:id
  def destroy
    @like = Like.find(params[:id])
    @like.destroy

    redirect_to project_path(@project), flash: { success: 'Project was successfully unliked.' }
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: projects_path, flash: { error: 'Like was not found.' })
  end

  private

  def project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: projects_path, flash: { error: 'Project was not found.' })
  end
end
