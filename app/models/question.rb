class Question < ApplicationRecord
  belongs_to :author, class_name: "User", optional: true
  belongs_to :user

  validates :body, presence: true, length: { maximum: 280 }
end
