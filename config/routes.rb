Rails.application.routes.draw do
  devise_for :users
  root 'contacts#index'
  resources :contacts do
    collection do
      get :download_csv
      post :import_csv
    end
  end
  resources :documents, :only => [ :index]
  # get '/contact/contacts-layout-csv', to: 'contacts#download_csv', as: 'contact_layout_csv'
  # post '/contact/import-csv', to: 'contacts#import_csv', as: "import_contact_csv"
end
