# app/controllers/admin_controller.rb
class AdminController < ApplicationController
  before_action :user, only: %i[approve reject]
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
                  flash: { success: "#{@user.full_name} is #{@user.admin ? 'now' : 'no longer'} an admin." })
  end

  # PUT /admin/users/:id/approve
  def approve
    @user.update(approved: true)

    redirect_back(fallback_location: admin_index_path, flash: { success: "#{@user.full_name} is now approved" })
  end

  # PUT /admin/users/:id/reject
  def reject
    return if @user.approved

    if @user.destroy
      redirect_to admin_index_path, flash: { success: "#{@user.full_name} has been rejected" }
    else
      redirect_to admin_index_path, flash: { error: "#{@user.full_name} couldn't be rejected" }
    end
  end

  private

  def authorize_admin
    redirect_back(root_path) unless current_user.admin
  end

  def user
    @user = User.find(params[:id])
  end

  def users
    @users = User.all.order(:first_name)
    @unauthenticated_users = User.all.where(approved: false)
  end
end
