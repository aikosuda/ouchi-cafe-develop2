class Review < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  
  belongs_to :user
  belongs_to :review_category
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  attachment :image

  validates :name, presence: true, length: { maximum: 50 }
  validates :content, presence: true
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1,
  }, presence: true
  validates :price, numericality: { only_integer: true }

  # 商品名で検索
  def self.search_review(search)
    where(['name LIKE ?', "%#{search}%"])
  end

  # いいねの有無をチェック
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # 投稿したレビューにいいねされたら通知
  def create_notification_favorite_review!(current_user)
    temp = Notification.where([
      "visitor_id = ? and visited_id = ? and review_id = ? and action = ? ",
      current_user.id, user_id, id, 'favorite',
    ])
    if temp.blank?
      notification = current_user.active_notifications.new(
        review_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
     end
      notification.save if notification.valid?
     end
  end
end
