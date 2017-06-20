class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def show
    # require "pry"; binding.pry
    render json: Customer.fav_customer(params[:merchant_id].to_i)
  end
end
