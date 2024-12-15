Rails.application.routes.draw do
  # トップページ
  root to: 'home#index'

  # Deviseルーティング
  devise_for :users

  # ホームページ
  get "home/index"

  # ダッシュボード
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

  # 目標（goals）とそれに関連する日記（diaries）のルーティング
  resources :goals, only: [:new, :create, :index, :show, :destroy] do
    resources :diaries, only: [:new, :create, :index, :show, :destroy]
  end

  # PWA関連
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
