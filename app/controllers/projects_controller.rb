class ProjectsController < ApplicationController
  def index
    @projects = Project.includes(:user)
  end
end
