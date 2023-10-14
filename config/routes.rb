Rails.application.routes.draw do
  namespace :api do
    get 'favorites/index'
    get 'favorites/create'
    get 'favorites/destroy'
    get 'comments/create'
    get 'comments/update'
    get 'comments/destroy'
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
      end
      member do
        post 'favorite', to: 'favorites#create'
        delete 'unfavorite', to: 'favorites#destroy'
      end
      resources :comments, only: [:create, :update, :destroy]
    end

    get '/posts/:id/favorite_status', to: 'favorites#favorite_status'
  end
end
