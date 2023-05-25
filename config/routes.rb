Rails.application.routes.draw do
   #会員用のトップページ
   root to: 'public/homes#top'
    get '/about' => 'public/homes#about'

  #会員用(新規登録・ログイン)
 devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
 }
 #会員用(新規登録・ログイン)
 scope module: :public do
    get 'customers/' => 'customers#index'
    get 'customers/mypage' => 'customers#show', as: 'mypage'
    get 'customers/information/edit/:id' => 'customers#edit', as: 'edit_information'
    patch 'customers/information' => 'customers#update', as: 'update_information'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw'
    get 'favorites' => 'favorites#index', as: 'favorites'

    resources :reviews, only: [:index,:new,:create,:show,:edit,:update,:destroy] do
      resources :comments, only: [:create,:destroy]
      resource :favorites, only: [:create,:destroy]
    end
    resources :myreviews, only: [:index,:destroy]
 end

  #管理者用(ログイン)
 devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
 }

  #管理者用トップページ(レヴュー一覧)
  get '/admin' => 'admin/homes#top'
 #管理者用
 namespace :admin do
  resources :reviews, only: [:show,:destroy]
  resources :types, only: [:index,:create,:edit,:update,:destroy]
  resources :soups, only: [:index,:create,:edit,:update,:destroy]
  resources :customers, only: [:index,:show,:edit,:update]
  end

  #ゲストユーザーログイン
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
 end
