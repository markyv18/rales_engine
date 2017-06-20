Rails.application.routes.draw do

  # mount Blazer::Engine, at: "blazer"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      # GET /api/v1/customers/:id/favorite_merchant
      namespace :customers do
        get "/find",      to: "find#show"
        get "/find_all",  to: "find#index"
        get "/random",    to: "random#index"
      end
      resources :customers, only:[:index, :show] do
      end



      namespace :invoice_items do
        get "/find",      to: "find#show"
        get "/find_all",  to: "find#index"
        get "/random",    to: "random#index"
      end
      resources :invoice_items, only:[:index, :show] do
        get "/invoice",   to: "invoice_items/invoice#show"
        get "/item",      to: "invoice_items/item#show"
      end



      namespace :invoices do
        get "/find",      to: "find#show"
        get "/find_all",  to: "find#index"
        get "/random",    to: "random#index"
      end
      resources :invoices, only:[:index, :show] do
        get "/customer",          to: "invoices/customer#show"
        get "/merchant",          to: "invoices/merchant#show"
      end



      # GET /api/v1/items/most_revenue?quantity=x
      # GET /api/v1/items/:id/best_day
      # GET /api/v1/items/most_items?quantity=x
      namespace :items do
        get "/find",      to: "find#show"
        get "/find_all",  to: "find#index"
        get "/random",    to: "random#index"
      end
      resources :items, only:[:index, :show] do
        get "/merchant",          to: "items/merchant#show"
        get "/invoice_items",     to: "items/invoice_items#index"
      end



      # GET /api/v1/merchants/revenue?date=x
      # GET /api/v1/merchants/most_revenue?quantity=x
      # GET /api/v1/merchants/:id/customers_with_pending_invoices
      # GET /api/v1/merchants/:id/favorite_customer
      # GET /api/v1/merchants/:id/revenue
      # GET /api/v1/merchants/:id/revenue?date=x
      # GET /api/v1/merchants/most_items?quantity=x
      namespace :merchants do
        get "/find",      to: "find#show"
        get "/find_all",  to: "find#index"
        get "/random",    to: "random#index"
      end
      resources :merchants, only:[:index, :show] do
        get "/invoices",  to: "merchants/invoices#index"
        get "/items",     to: "merchants/items#index"
      end



      namespace :transactions do
        get "/find",      to: "find#show"
        get "/find_all",  to: "find#index"
        get "/random",    to: "random#index"
      end
      resources :transactions, only:[:index, :show] do
        get "/invoice",   to: "transactions/invoice#show"
      end

    end
  end
end





















#
