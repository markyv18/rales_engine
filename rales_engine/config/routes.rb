Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :customers do
        get "/find",      to: "find#show"
        get "/find_all",  to: "find#index"
        get "/random",  to: "random#index"
      end
      resources :customers, only:[:index, :show] do
      end

      namespace :merchants do
        get "/find",      to: "find#show"
        get "/find_all",  to: "find#index"
        get "/random",    to: "random#index"
      end
      resources :merchants, only:[:index, :show] do
      end

      namespace :transactions do
        get "/find",      to: "find#show"
        get "/find_all",  to: "find#index"
        get "/random",    to: "random#index"
      end
      resources :transactions, only:[:index, :show] do
      end

      namespace :invoices do
        get "/find",      to: "find#show"
        get "/find_all",  to: "find#index"
        get "/random",  to: "random#index"
      end
      resources :invoices, except:[:new, :edit] do
      end

      namespace :items do
        get "/find",      to: "find#show"
        get "/find_all",  to: "find#index"
        get "/random",    to: "random#index"
      end
      resources :items, except:[:new, :edit] do
      end

      namespace :invoice_items do
        get "/find",      to: "find#show"
        get "/find_all",  to: "find#index"
        get "/random",    to: "random#index"
      end
      resources :invoice_items, except:[:new, :edit] do
      end

    end
  end
end
# /api/v1/invoice_items/
#Api::V1::InvoiceItems::FindAllController
