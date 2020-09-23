class BlogComment < ApplicationRecord
	belongs_to :user
	belongs_to :blog
	has_many :notifications, dependent: :destroy

	validates :comment, presence: true

end
