Rails.application.routes.draw do
  resources :cliente do
    resources :pet
  end
  resources :servico do 
    get :search, on: :collection, constraints: {
      data_agendamento: /\d{4}-\d{2}-\d{2}/
    }
  end

end
