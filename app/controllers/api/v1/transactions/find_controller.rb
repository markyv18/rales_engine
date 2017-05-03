class Api::V1::Transactions::FindController < ApplicationController
  def index
    render json: Transaction.where(find_params)
  end

  def show
    render json: Transaction.find_by(find_params)
  end

  private

  def find_params
    params.permit(:id, :credit_card, :result, :invoice_id, :created_at, :updated_at)
  end
end
