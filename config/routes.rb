Rails.application.routes.draw do
  root to: 'home#index' # トップページを設定

  get "home/index"
  devise_for :users # Deviseルーティングを有効化
  resources :goals, only: [:new, :create, :index, :show, :destroy]
  resources :diaries
  get '/goalform', to: 'goals#new'  # フォーム表示
  post '/goals', to: 'goals#create' # フォーム送信
  # ダッシュボードのルート
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  # その他のルート
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
