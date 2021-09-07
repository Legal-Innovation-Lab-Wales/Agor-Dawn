# app/controllers/admin_controller.rb
class AdminController < ApplicationController
  before_action :users
  before_action :authorize_admin, only: :index

  # GET /user/admin
  def show
    render 'show'
  end

  # PUT /admin/users/:id
  def toggle_admin
    @user = User.find(params[:id])
    @user.update!(admin: !@user.admin)

    redirect_back(fallback_location: projects_path,
                  flash: { success: "#{@user.full_name} is #{@user.admin ? 'now' : 'no longer'} an admin."})
  end

  private

  def authorize_admin
    redirect_to root_path, flash: { error: 'You do not have access to this page '} unless current_user.admin
  end

  def users
    @users = User.all.order(:first_name)
  end
end