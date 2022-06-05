class Hashtag < ApplicationRecord
  has_many :question_with_hashtags, dependent: :destroy
  has_many :questions, through: :question_with_hashtags

  validates :name, presence: true
end
