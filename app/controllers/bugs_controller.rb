# app/controllers/bugs_controller.rb
class BugsController < ApplicationController
  before_action :bug_params, only: :create

  def new
    render 'new'
  end

  def create
    User.admins.each { |admin| BugsMailer.new_bug(admin, current_user, params[:summary], params[:description]).deliver_now }

    redirect_back(fallback_location: new_bug_path, flash: { success: 'Thank you for your submission. Our team have been alerted and will begin investigating the issue.' })
  end

  private

  def bug_params
    params.require(%i[summary description])
  end
end
