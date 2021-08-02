class ProjectsController < ApplicationController
  def index
    @projects = Project.includes(:user)
  end

  def show
    @project = Project.includes(:user, :comments).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: root_path, flash: { error: 'Project event not found' })
  end

  def like
    #Getting the project
    @project = Project.all.find(params[:id])
    #creating a like with that project and that users ID
    Like.create(user_id: current_user.id, project_id: @project.id)
    #redirect back to project
    redirect_to project_path(@project)
  end
end
