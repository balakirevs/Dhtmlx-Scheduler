DhtmlxScheduler::Application.routes.draw do
  constraints(id: /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/i) do
    devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
    ActiveAdmin.routes(self)
    resources :teams
    resources :groups, only: :index
    resources :mates, only: :index
    resources :members, only: :index
    resources :users
    resources :works
    resources :ams, controller: 'works', type: 'Am'
    resources :pms, controller: 'works', type: 'Pm'
    resources :events  
    root to: 'events#schedule'
    match 'events/save', to: 'events#save', as: :save, via: [:get, :post]
    get '/schedule', to: 'events#schedule', as: 'schedule'
  end
end
