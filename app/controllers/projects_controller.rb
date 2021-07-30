class ProjectsController < ApplicationController
  

  def index
    @projects = Project.includes(:user)
  end

  def show
    @project = Project.includes(:user, :comments).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: root_path, flash: { error: 'Project event not found' })
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
end
