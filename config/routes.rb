Rails.application.routes.draw do
  devise_for :users  # devise のルートを最初に置きます
  root "home#index"   # トップページを表示
  get 'home/index'    # home#index へのルート
end