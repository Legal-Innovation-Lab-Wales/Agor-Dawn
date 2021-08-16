# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :project

  # POST /projects/:project_id/comments
  def create
    @project.comments.create!(comment: comment_params[:comment_text], user: current_user)
    redirect_to project_path(@project), flash: { success: 'Comment was successfully submitted.' }
  end

  private
  def project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: projects_path, flash: { error: 'Project was not found.' })
  end

  def comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.permit(:comment_text)
  end

end