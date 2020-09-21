class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :blogs, dependent: :destroy
  has_many :blog_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

  attachment :profile_image

  validates :name, presence: true


  #会員名でレビュー検索
  def self.search_review(search)
    self.where(['name LIKE ?', "%#{search}%"])
  end

  #会員名でブログ検索
  def self.search_blog(search)
    self.where(['name LIKE ?', "%#{search}%"])
  end

  #ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  
  #ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  
  #フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

end
