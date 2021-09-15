class Recipe < ApplicationRecord
    belongs_to :user
    attachment :image

    has_many :comments
    has_many :likes, dependent: :destroy

    with_options presence: true do
        validates :title
        validates :body
        validates :image
    end

end
