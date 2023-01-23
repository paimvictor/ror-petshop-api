Rails.application.routes.draw do
  resources :clientes do
    resources :pets
  end
  resources :servicos do 
    get :search, on: :collection, constraints: {
      data_agendamento: /\d{4}-\d{2}-\d{2}/
    }
  end

end
