Rails.application.routes.draw do
  resources :client
  resources :pet
  resources :service do 
    get :search, on: :collection, constraints: {
      scheduled_date: /\d{4}-\d{2}-\d{2}/ # YYYY-MM-DD
    }
  end

end
