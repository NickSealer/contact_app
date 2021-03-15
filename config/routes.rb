Rails.application.routes.draw do
  devise_for :users
  root 'contacts#index'
  resources :contacts do
    collection do
      get :download_csv
      post :import_csv
    end
  end
  resources :documents, only: [ :index]

  namespace 'api' do
    namespace 'v1' do
      resources :contacts, except: [:new, :edit]
    end
  end

end
