Rails.application.routes.draw do
  # 部屋に関連した予約のルート
  resources :rooms do
    collection do
      get 'search'  # 検索機能
    end
  
    resources :reservations, only: [:new, :create] do
      collection do
        get 'confirm'   # 確認ページ表示用
        post 'confirm'  # 予約確定処理用
      end
    end
  end

  # 予約一覧を追加
  resources :reservations, only: [:index]

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
