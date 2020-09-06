class Review < ApplicationRecord
	belongs_to :user
	belongs_to :review_category

	validates :name, presence: true, length:{maximum:50}
	validates :content, presence: true
end
