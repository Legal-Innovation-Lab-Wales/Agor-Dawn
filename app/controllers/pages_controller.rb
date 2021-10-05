# app/controllers/pages_controller.rb
class PagesController < ApplicationController

  def home
    @projects = Project.includes(:user).is_public
    @projects = @projects.not_flagged(current_user.id) unless current_user.admin
    @projects = @projects.most_recent.limit(4)

    render 'home'
  end
end
