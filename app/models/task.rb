class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  # 各タスクは1人のユーザーに属する
  belongs_to :user
end
