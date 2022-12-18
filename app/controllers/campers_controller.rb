class CampersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid

  def render_invalid(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
  
  def render_not_found
    render json: {error: "Camper not found" }, status: :not_found
  end

  def index
    render json: Camper.all, status: :ok
  end
  def show
    camper = Camper.find_by!(id: params[:id])
    render json: camper, status: :ok, serializer: CamperActivtiesSerializer
  end
  def create
    camper = Camper.create!(camper_params)
    render json: camper, status: :created
  end

  private
  def camper_params
    params.permit(:name, :age)
  end
end
