class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy
  has_many :blogs, through: :tag_maps

  validates :name, presence: true, length: { maximum: 30 }
end
