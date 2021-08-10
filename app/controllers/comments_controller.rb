# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
    before_action :project

    # POST /projects/:project_id
    def create
      Comment.create!(user: current_user, project: @project)

      redirect_to project_path(@project), flash: { success: 'Comment was successfully submitted.' }
    end

  private
  def comment
    @comment = Comment.find(params[:comment_id])
  end

  def project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: projects_path, flash: { error: 'Project was not found.' })
  end

end