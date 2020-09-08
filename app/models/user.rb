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


  #会員名で検索
  def self.search(search, user_or_product)
    if user_or_product == "1"
      self.where(['name LIKE ?', "%#{search}%"])
    else
       self.all
    end
  end
end
