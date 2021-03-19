# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'contacts#index'
  resources :contacts do
    collection do
      get :download_csv
      post :import_csv
    end
  end
  resources :documents, only: [:index]

  namespace 'api' do
    namespace 'v1' do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :contacts, except: %i[new edit]
    end
  end
end
