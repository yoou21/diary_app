Rails.application.routes.draw do
  # トップページ
  root to: 'home#index'

  # Devise
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # ホームページ・ダッシュボード
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

  # 目標（goals）と日記（diaries）のルーティング
  resources :goals, only: [:new, :create, :index, :show, :destroy] do
    resources :diaries, only: [:new, :create, :index, :show, :destroy] do
      collection do
        get :emotion_scores  # API用エンドポイント
      end
    end
    collection do
      post :score_calculation, to: 'goals#score_calculation', as: 'score_calculation'
    end
  end

  # API用のルーティング
  namespace :api do
    resources :diary_entries, only: [:index] do
      collection do
        get :emotion_summary
      end
    end
  end

  # PWA関連
  namespace :pwa do
    get :service_worker, to: "pwa#service_worker", as: :service_worker
    get :manifest, to: "pwa#manifest", as: :manifest
  end

  # Health check
  get 'up' => 'rails/health#show', as: :rails_health_check
end
