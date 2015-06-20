Rails.application.routes.draw do
  root 'main#home'
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' },
             skip:        [:sessions, :registrations]
  devise_scope :user do
    delete 'users/sign_out(.:format)' => 'devise/sessions#destroy', as: 'destroy_user_session'
    get '/api/current_user' => 'users/sessions#show_current_user', as: 'show_current_user'
    post '/api/check/is_admin' => 'users/sessions#is_admin', as: 'is_admin'
  end
  resources :entries
  get '/admin', to: 'main#admin'
  get '/admin/*path', to: 'main#admin'
  namespace :api, defaults: { format: :json } do
    resources :users
    resources :settings, only: [:index, :update]
  end
end
