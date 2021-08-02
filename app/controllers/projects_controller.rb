class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :project_params, only: %i[create update]
  before_action :project, only: %i[edit]

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

    render 'new'
  end

  def create
    @project = current_user.projects.create(project_params)
    
    if @project.valid?
      flash[:success] = 'Successfully created project!'
    else
      flash[:error] = 'Error creating project'
    end
    
    render 'new'
  end

  def edit
    render 'projects/edit'
  end

  def update

  end

  def destroy
    
  end

  private

  def project
    # @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :summary, :description, :public)
  end
end
