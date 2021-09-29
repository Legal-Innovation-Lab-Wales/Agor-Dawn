# app/controllers/admin_controller.rb
class AdminController < ApplicationController
  before_action :authorize_admin
  before_action :user, except: :index
  before_action :users

  # PUT /admin/users/:id/make_admin
  def make_admin
    @user.update!(admin: true)

    redirect_back(fallback_location: projects_path, flash: { success: "#{@user.full_name} is now an admin." })
  end

  # PUT /admin/users/:id/approve
  def approve
    @user.update(approved: true)

    redirect_back(fallback_location: admin_index_path, flash: { success: "#{@user.full_name} is now approved" })
  end

  # PUT /admin/users/:id/reject
  def reject
    return if @user.approved

    flash[:success] = "#{@user.full_name} has been rejected" if @user.destroy
    flash[:error] = "#{@user.full_name} couldn't be rejected" unless flash[:success].present?

    redirect_back(fallback_location: admin_index_path)
  end

  private

  def authorize_admin
    redirect_back(fallback_location: authenticated_root_path) unless current_user.admin
  end

  def user
    @user = User.find(params[:id])
  end

  def users
    @unapproved_users = User.unapproved.order(:first_name)
    @approved_users = User.approved.order(:first_name)
  end
end
