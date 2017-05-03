Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :invoice_items do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
      end
      namespace :items do
        get '/most_items', to: 'most_items#index'
      end
      resources :items, except: [:new, :edit]
      resources :invoices, except: [:new, :edit]
      resources :invoice_items, except: [:new, :edit]
      # get 'i/nvoice_items', to: 'invoice_items#index'
      # get 'i/nvoice_items/:id', to: 'invoice_items#show'
    end
  end
end
# /api/v1/invoice_items/
#Api::V1::InvoiceItems::FindAllController
