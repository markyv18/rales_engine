class Api::V1::Invoices::FindController < ApplicationController
  def index
    render json: Invoice.where(strong_params)
  end

  def show
    render json: Invoice.find_by(strong_params)
  end

  private

  def strong_params
    params.permit(:id, :name, :description, :created_at, :updated_at)
  end
end
