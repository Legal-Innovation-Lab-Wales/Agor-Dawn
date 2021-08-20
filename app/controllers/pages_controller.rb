# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @projects = Project.includes(:user)
                       .is_public
                       .most_recent
                       .limit(5)

    render 'home'
  end
end
