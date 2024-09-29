Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # ログイン後の画面をタスク一覧に設定
  root 'tasks#index'  
  # タスクのCRUD機能のためのルーティング作成
  resources :tasks

  # ユーザの登録フォームを作成するため、newアクションを設定
  # onlyを指定することで、特定のアクションのルーティングのみ作成

   #  form_withを使用するにはルーティングにcreateアクションを追加
   #  データベースから特定のユーザーの情報を取得して表示するshowアクションを追加
   resources :users, only: [:new, :create, :show, :edit, :update, :destroy]

   # ログイン機能のSessionsコントローラ用のルーティング
   # destroyはSessionsコントローラにログアウトを行うためのdestroyアクション
   resources :sessions, only: [:new, :create, :destroy]
end
