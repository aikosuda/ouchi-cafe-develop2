class Review < ApplicationRecord
	belongs_to :user
	belongs_to :review_category
	has_many :favorites, dependent: :destroy

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

  	#いいねの有無をチェック
  	def favorited_by?(user)
  		favorites.where(user_id: user.id).exists?
  	end
end
