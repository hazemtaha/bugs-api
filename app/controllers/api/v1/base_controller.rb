class Api::V1::BaseController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :render_unprocessable_entity
  rescue_from ArgumentError, with: :render_unprocessable_entity

  def render_unprocessable_entity(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end
end
