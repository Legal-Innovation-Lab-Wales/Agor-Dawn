# app/controllers/bugs_controller.rb
class BugsController < ApplicationController
  before_action :bugs_params, only: :create

  def new
    render 'new'
  end

  def create
    # TODO: Send admins an email notifying them of a new bug
  end

  private

  def bug_params
    params.require(%i[summary description])
  end
end
