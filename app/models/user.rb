class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :relationships, foreign_key: :following_id
  has_many :followings, through: :relationships, source: :follower

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :reverse_of_relationships, source: :following
  has_many :comments
  has_many :likes, dependent: :destroy


  has_many :recipes, dependent: :destroy

  def already_liked?(recipe)
    self.likes.exists?(recipe_id: recipe.id)
  end

  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end
  
  has_many :recipes, dependent: :destroy
  attachment :profile_image

  validates :username, presence: true
end
