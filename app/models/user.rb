class User < ApplicationRecord
  include Gravtastic
  extend FriendlyId

  VALID_EMAIL = /\A[\w\d]+@[\w\d]+\.[\w]+/
  VALID_NICKNAME = /\A\w+\z/
  VALID_COLOR = /\A#\h{3}{1,2}\z/

  has_many :authored_questions, class_name: "Question", foreign_key: "author_id", dependent: :nullify
  has_many :questions, dependent: :delete_all

  has_secure_password

  friendly_id :nickname, use: :slugged
  gravtastic(secure: true, filetype: :png, size: 100, default: "robohash")

  before_validation :downcase_nickname

  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL }
  validates :navbar_color, format: { with: VALID_COLOR }
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 40 }, format: { with: VALID_NICKNAME }

  private

  def downcase_nickname
    nickname&.downcase!
  end
end
