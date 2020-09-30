class Blog < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  
  belongs_to :user
  has_many :blog_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :notifications, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true

  # タグの更新処理
  def save_tag(sent_tags)
    current_tags = tags.pluck(:name) unless tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    # タグを消去する
    old_tags.each do |old_tag|
      tags.delete Tag.find_by(name: old_tag)
    end

    # タグを作成する
    new_tags.each do |new_tag|
      new_blog_tag = Tag.find_or_create_by(name: new_tag)
      tags << new_blog_tag
    end
  end

  # タイトル名で検索
  def self.search_blog(search)
    where(['title LIKE ?', "%#{search}%"])
    end

  # いいねの有無をチェック
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
   end

  # 投稿したブログにいいねされたら通知
  def create_notification_favorite_blog!(current_user)
    temp = Notification.where([
      "visitor_id = ? and visited_id = ? and blog_id = ? and action = ? ",
      current_user.id, user_id, id, 'favorite',
    ])
    if temp.blank?
      notification = current_user.active_notifications.new(
        blog_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
        end
      notification.save if notification.valid?
     end
   end

  # 投稿したブログにコメントが来たら通知
  def create_notification_comment!(current_user, blog_comment_id)
    temp_ids = BlogComment.where(Blog_id: id).where.not("user_id=? or user_id=?", current_user.id, user_id).select(:user_id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, blog_comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, blog_comment_id, user_id)
   end

  def save_notification_comment!(current_user, blog_comment_id, visited_id)
    notification = current_user.active_notifications.new(
      blog_id: id,
      blog_comment_id: blog_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
