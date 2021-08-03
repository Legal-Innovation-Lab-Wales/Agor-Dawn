class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :project_params, only: %i[create update]
  before_action :project, only: %i[edit update destroy]

  # GET /projects
  def index
    @projects = Project.includes(:user)
  end

  # GET /projects/:id
  def show
    @project = Project.includes(:user, :comments).find(params[:id])
    @numOfLikes = Like.all.where("project_id = ?", @project.id).count
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: projects_path, flash: { error: 'Project not found' })
  end

  # GET /projects/new
  def new
    @project = Project.new

    render 'new'
  end

  # POST /projects
  def create
    @project = current_user.projects.create(project_params)
    
    if @project.valid?
      flash[:success] = 'Successfully created project!'
    else
      flash[:error] = 'Error creating project'
    end
    
    render 'new'
  end

  # GET /projects/:id/edit
  def edit
    render 'edit'
  end

  # PUT /projects/:id
  def update
    @project.update(project_params)
    
    if @project.valid?
      flash[:success] = 'Successfully updated project!'
    else
      flash[:error] = 'Error updating project'
    end
    
    render 'edit'
  end

  # DELETE /projects/:id
  def destroy
    @project.destroy
    redirect_to projects_path, flash: { success: 'Project deleted' }
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

  private

  def project
    @project = current_user.projects.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: projects_path, flash: { error: 'You do not have permission to do that' })
  end

  def project_params
    params.require(:project).permit(:name, :summary, :description, :public)
  end

end
