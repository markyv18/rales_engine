class Api::V1::Items::FindController < ApplicationController
  def index
    render json: Item.where(strong_params)
  end

  def show
    render json: Item.find_by(strong_params)
  end

  private

  def strong_params
    params.permit(:id, :name, :description, :unit_price, :created_at, :updated_at)
  end
end
