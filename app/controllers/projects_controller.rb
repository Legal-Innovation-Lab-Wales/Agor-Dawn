class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find_by(id: params[:id])
    if @project.nil?
      redirect_to action: :index
    end
  end

  private
  def project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: root_path, flash: { error: 'Project event not found' })
  end
end
