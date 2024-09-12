Rails.application.routes.draw do
  resources :rooms

  # Deviseルートとカスタムコントローラの設定
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # アカウントとプロフィールのルートをdevise_scope内に統一
  devise_scope :user do
    get 'account', to: 'users/registrations#show', as: :account
    get 'profile', to: 'users#profile', as: :profile
    get 'profile/edit', to: 'users#edit_profile', as: :edit_profile
    patch 'profile', to: 'users#update_profile', as: :update_profile
  end

  # アプリケーションのルートと他のページ
  root to: 'shukuhaku#yoyaku'
  get 'shukuhaku/yoyaku'
end
