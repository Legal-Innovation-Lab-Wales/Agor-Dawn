# app/controllers/projects_controller.rb
class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :project_params, only: %i[create update]
  before_action :project, except: %i[index new create]
  before_action :redirect, only: %i[edit update destroy], unless: -> { project_owner? }
  before_action :verify_public, :increment_viewcount, only: :show

  # GET /projects
  def index
    @categories = %w[recent popular]
    @projects = Project.includes(:user)
                       .is_public
                       .order(sort)

    @projects = @projects.search(search_params[:query]) if search_params[:query].present?

    category
  end

  # GET /projects/:id
  def show
    @like = @project.likes.find_by(user: current_user)
    @count = @project.likes.count
    @liked_by = @project.likes.includes(:user)
                        .order(created_at: :desc)
                        .limit(20)
                        .map { |like| like.user.full_name.to_s }
                        .join("\n")
    @liked_by += "\nand #{@count - 20} more..." if @count > 20
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
      redirect_to project_path(@project)
    else
      flash[:error] = 'Error creating project'
      render 'new'
    end
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
      redirect_to project_path(@project)
    else
      flash[:error] = 'Error updating project'
      render 'edit'
    end
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
    params.require(:project).permit(:name, :summary, :public, :content)
  end

  def search_params
    params.permit(:query)
  end

  def category
    @category = if params[:category].present? && params[:category].downcase.in?(@categories)
                  params[:category]
                else
                  'recent'
                end
  end

  def sort
    category
    if @category == 'recent'
      { 'created_at': 'desc' }
    elsif @category == 'popular'
      { 'created_at': 'asc' }
    end
  end

  def redirect
    redirect_back(fallback_location: projects_path, flash: { error: 'You cannot do that action.' })
  end

  def success(action)
    { success: "Project successfully #{action}d." }
  end

  def increment_viewcount
    return if project_owner?

    @project.update!(view_count: @project.view_count + 1)
  end

  def verify_public
    return if @project.public || current_user == @project.user

    redirect_back(fallback_location: projects_path, flash: { error: 'Project was not found.' })
  end

  def project_owner?
    @project.user == current_user
  end
end
