class BlogComment < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  
  belongs_to :user
  belongs_to :blog
  has_many :notifications, dependent: :destroy

  validates :comment, presence: true
end
