class Review < ApplicationRecord
	belongs_to :user
	belongs_to :review_category

	attachment :image

	validates :name, presence: true, length:{maximum:50}
	validates :content, presence: true
	validates :rate, numericality: {
		less_than_or_equal_to: 5,
		greater_than_or_equal_to: 1
	}, presence: true

	#商品名で検索
	def self.search_review(search)
    	self.where(['name LIKE ?', "%#{search}%"])
  	end
end
