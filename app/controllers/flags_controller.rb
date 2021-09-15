# app/controllers/flags_controller.rb
class FlagsController < ApplicationController
  before_action :authorize_admin
  before_action :flags

  def index
    render 'index'
  end

  private

  def flags
    @flags = Flag.includes(:user)
                 .is_under_review
                 .most_recent
  end
end
