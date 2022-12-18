class SignupsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :invalid

  def create
    signup = Signup.create!(sign_params)
    render json: signup.activity, status: :created
  end

  private

  def invalid(invalid)
    render json: {
             errors: invalid.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end

  def sign_params
    params.permit(:camper_id, :activity_id, :time)
  end
end
