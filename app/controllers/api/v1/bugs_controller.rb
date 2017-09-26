class Api::V1::BugsController < Api::V1::BaseController
  before_action :set_bug, only: %i[show update destroy]

  # GET /bugs/1
  def show
    if @bug.present?
      render json: @bug
    else
      render :head, status: :not_found
    end
  end

  # POST /bugs
  def create
    @bug = Bug.new(bug_params)
    @bug.state = State.new(state_params)
    if @bug.save
      render json: { number: @bug.number }, status: :created
    else
      render json: @bug.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bug
    @bug = Bug.find_by(
      application_token: params[:application_token], number: params[:number]
    )
  end

  # Only allow a trusted parameter "white list" through.
  def bug_params
    params.permit(:application_token, :status, :priority, :comment)
  end

  def state_params
    params.require(:state).permit(:device, :os, :memory, :storage)
  end
end
