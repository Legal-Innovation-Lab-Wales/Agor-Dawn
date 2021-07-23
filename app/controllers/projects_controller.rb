class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.includes(:user, :comments).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: root_path, flash: { error: 'Project event not found' })
  end
end
