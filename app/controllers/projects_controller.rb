class ProjectsController < ApplicationController
  # GET /projects
  def index
    @projects = Project.includes(:user)
  end

  # GET /projects/:id
  def show
    @project = Project.includes(:user, :comments).find(params[:id])
    @numOfLikes = Like.all.where("project_id = ?", @project.id).count
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: root_path, flash: { error: 'Project event not found' })
  end

  # PUT /projects/:id/like
  def like
    @project = Project.all.find(params[:id])
    Like.create(user_id: current_user.id, project_id: @project.id)
    redirect_to project_path(@project)
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: project_path, flash: {error: 'Something went wrong'})
  end

  # DELETE /projects/:id/unlike
  def unlike
    @project = Project.all.find(params[:id])
    @like = Like.all.where("user_id =? AND project_id = ?", current_user.id, @project.id)
    Like.delete(@like)
    redirect_to project_path(@project)
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: project_path, flash: {error: 'Something went wrong'})
  end

end
