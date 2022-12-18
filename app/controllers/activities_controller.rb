class ActivitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    render json: Activity.all, status: :ok
  end

  def destroy
    activity = Activity.find_by!(id: params[:id])
    activity.signups.destroy_all
    activity.destroy
    head :no_content
  end

  private

  def not_found
    render json: { error: "Activity not found" }, status: :not_found
  end
end
