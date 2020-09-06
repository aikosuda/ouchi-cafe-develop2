class Tag < ApplicationRecord
	has_many :blogs, through: :tag_maps
	has_many :tag_maps, dependent: :destroy

	validates :name, presence: true, length:{maximum:30}
end
