class User < ApplicationRecord
  VALID_EMAIL = /\A[\w\d]+@[\w\d]+\.[\w]+/
  VALID_NICKNAME = /\A\w+\z/

  has_secure_password

  before_save :downcase_nickname

  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL }
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 40 }, format: { with: VALID_NICKNAME }

  private

  def downcase_nickname
    nickname&.downcase!
  end
end
