class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :project_params, only: %i[create update]

  def index
    @projects = Project.includes(:user)
  end

  def show
    @project = Project.includes(:user, :comments).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: root_path, flash: { error: 'Project not found' })
  end

  def new
    @project = Project.new

    render 'projects/new'
  end

  def create
    
  end

  def edit
    render 'projects/edit'
  end

  def update

  end

  def destroy
    
  end

  private

  def project_params
    params.require(:project).permit(:name, :summary, :description, :public)
  end
end
