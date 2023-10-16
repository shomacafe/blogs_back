Rails.application.routes.draw do
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }

    namespace :auth do
      resources :sessions, only: %i[index]
    end

    resources :posts, only: [:index, :show, :create, :update, :destroy] do
      collection do
        get 'blogs', to: 'posts#index_for_blogs'
        get :index_by_user
        get :my_posts
        get 'favorite_posts', to: 'favorites#favorite_posts'
      end
      member do
        post 'favorite', to: 'favorites#create'
        delete 'unfavorite', to: 'favorites#destroy'
        get 'favorite_status', to: 'favorites#favorite_status'
      end
      resources :comments, only: [:create, :update, :destroy]
    end
  end
end
