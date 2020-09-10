class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :blogs, dependent: :destroy
  has_many :blog_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, presence: true


  #会員名でレビュー検索
  def self.search_review(search)
    self.where(['name LIKE ?', "%#{search}%"])
  end

  #会員名でブログ検索
  def self.search_blog(search)
    self.where(['name LIKE ?', "%#{search}%"])
  end

end
