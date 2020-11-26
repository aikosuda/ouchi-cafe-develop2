class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :blog, optional: true
  belongs_to :review, optional: true
end
