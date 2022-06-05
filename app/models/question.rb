class Question < ApplicationRecord
  belongs_to :author, class_name: "User", optional: true
  belongs_to :user
  has_many :question_with_hashtags, dependent: :destroy
  has_many :hashtags, through: :question_with_hashtags

  validates :body, presence: true, length: { maximum: 280 }
end
