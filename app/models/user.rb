class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }#presence: true⇛name属性は必ず入力
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, confirmation: true

  # 大文字と小文字の区別をなくす
  before_validation { email.downcase! }

  # パスワードをハッシュ化
  # has_secure_passwordと書くことでユーザーが新規登録を行う際には password と password_confirmation が必須になります
  has_secure_password

    # パスワードにバリデーションを設定
    validates :password, length: { minimum: 6 }

    # User モデルと Task モデルの間にアソシエーションを設定
    # ユーザーが削除されると、そのユーザーに関連するタスクも削除
    has_many :tasks, dependent: :destroy
end
