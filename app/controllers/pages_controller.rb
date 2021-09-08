# app/controllers/pages_controller.rb
class PagesController < ApplicationController

  def home
    @projects = Project.includes(:user)
                       .is_public
                       .most_recent
                       .limit(4)

    render 'home'
  end
end
