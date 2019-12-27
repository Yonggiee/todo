Rails.application.routes.draw do
  root 'items#index'
  get 'items/calendar' => 'items#calendar'
  resources :items do 
    member do
      patch :complete, :undo_complete
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
