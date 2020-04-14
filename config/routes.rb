Rails.application.routes.draw do

  scope :panel, module: 'role/panel', as: :panel do

    resources :roles do
      member do
        get :overview
      end
      resources :who_roles, only: [:index, :new, :create, :destroy]
    end
    resources :governs do
      post :sync, on: :collection
      member do
        patch :move_lower
        patch :move_higher
      end
      resources :rules do
        patch :sync, on: :collection
        member do
          patch :move_lower
          patch :move_higher
          get :roles
        end
      end
    end
    resources :govern_taxons do
      post :sync, on: :collection
    end
  end

  scope module: 'role' do
    scope path: ':who_type/:who_id' do
      resource :who_roles, only: [:show, :edit, :update]
    end
  end

end

