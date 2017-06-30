require 'sidekiq/web'

Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    authenticated :user do
      root "pages#home", as: :authenticated_root
    end

    unauthenticated do
      root "devise/sessions#new", as: :unauthenticated_root
    end
  end

  authenticate :user, lambda { |u| u.admin? } do
    scope '/admin' do
      mount Sidekiq::Web => '/sidekiq'
    end
  end

  # need to keep this so we can still use the `root_path` helper
  root "pages#home"

end
