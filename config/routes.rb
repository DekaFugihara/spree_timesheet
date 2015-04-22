Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :efforts
    resources :activities, path: "atividades"
    resources :time_sheets, path: "pontos"
  end
end