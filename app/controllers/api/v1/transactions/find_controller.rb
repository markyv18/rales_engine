class Api::V1::Transactions::FindController < ApplicationController
  def index
    render json: Transaction.where(strong_params)
  end

  def show
    render json: Transaction.find_by(strong_params)
  end

  private

  def strong_params
    params.permit(:id, :credit_card, :result, :invoice_id, :created_at, :updated_at)
  end
end
