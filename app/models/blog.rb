class Blog < ApplicationRecord
	belongs_to :user
	has_many :blog_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :tags, through: :tag_maps
	has_many :tag_maps, dependent: :destroy

	attachment :image

	validates :title, presence: true, length:{maximum:100}
	validates :content, presence: true

end
