# app/controllers/flags_controller.rb
class FlagsController < ApplicationController
  before_action :authorize_admin, except: :update
  before_action :flags, only: :index
  before_action :flag, only: :update
  before_action :resource, only: :create

  # GET /flags
  def index
    render 'index'
  end

  # POST /flags
  def create
    @flag = Flag.create!(flagged_by: current_user, reason: "Admin: #{flag_params[:reason]}", flaggable: @resource)

    redirect_back(fallback_location: root_path, flash: { success: "#{@resource.class.name} has been flagged." })
  end

  # PUT /flags/:id
  def update
    # TODO: Update resolved status...
  end

  private

  def flags
    @flags = Flag.includes(:flagged_by).most_recent
  end

  def flag
    @flag = Flag.includes(:flagged_by).find(params[:id])
  end

  def resource
    @resource = case flag_params[:resource_type]
                when 'project'
                  Project.includes(:user).find(flag_params[:resource_id])
                when 'comment'
                  Comment.includes(:user).find(flag_params[:resource_id])
                else
                  raise 'Attempting to flag an unknown resource'
                end
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: root_path, flash: { error: 'Resource Not Found.' })
  end

  def flag_params
    params.require(:flag).permit(:resource_type, :resource_id, :reason)
  end
end
