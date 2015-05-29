Rails.application.routes.draw do
  root 'main#home'
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' },
             skip:        [:sessions, :registrations]
  devise_scope :user do
    delete 'users/sign_out(.:format)' => 'devise/sessions#destroy', as: 'destroy_user_session'
  end
  resources :entries
  resources :main
  get 'submissions', to: 'main#index'
end
