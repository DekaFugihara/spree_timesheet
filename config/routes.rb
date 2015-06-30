Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :efforts
    resources :activities, path: "atividades"
    resources :time_sheets, path: "pontos" do
      get 'report', :on => :collection
    end
  end
end