# app/controllers/projects_controller.rb
class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :project_params, only: %i[create update]
  before_action :project, except: %i[index new]
  before_action :redirect, only: %i[edit update destroy], unless: -> { @project.user == current_user }

  # GET /projects
  def index
    @projects = Project.includes(:user)

    render 'index'
  end

  # GET /projects/:id
  def show
    @like = @project.likes.find_by(user: current_user)
    @liked_by = @project.likes.includes(:user)
                        .order(created_at: :desc)
                        .limit(20)
                        .map { |like| "#{like.user.full_name}" }
                        .join("\n")

    render 'show'
  end

  # GET /projects/new
  def new
    @project = Project.new

    render 'new'
  end

  # POST /projects
  def create
    @project = current_user.projects.create!(project_params)

    redirect_to project_path(@project), success('create')
  end

  # GET /projects/:id/edit
  def edit
    render 'edit'
  end

  # PUT /projects/:id
  def update
    @project.update(project_params)

    redirect_to project_path(@project), success('update')
  end

  # DELETE /projects/:id
  def destroy
    @project.destroy

    redirect_to projects_path, flash: success('delete')
  end

  private

  def project
    @project = Project.includes(:user, :comments, :likes).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: projects_path, flash: { error: 'Project was not found.' })
  end

  def project_params
    params.require(:project).permit(:name, :summary, :description, :public)
  end

  def redirect
    redirect_back(fallback_location: projects_path, flash: { error: 'You cannot do that action.' })
  end

  def success(action)
    { success: "Project successfully #{action}d." }
  end
end
