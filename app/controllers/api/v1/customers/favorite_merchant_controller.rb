class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  def show
    # require "pry"; binding.pry
    render json: Merchant.fav_merch(params[:customer_id].to_i)
  end
end
