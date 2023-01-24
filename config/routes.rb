Rails.application.routes.draw do
  resources :cliente
  resources :pet
  resources :servico do 
    get :search, on: :collection, constraints: {
      data_agendamento: /\d{4}-\d{2}-\d{2}/ # YYYY-MM-DD
    }
  end

end
