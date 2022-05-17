class User < ApplicationRecord
  VALID_EMAIL = /\A[\w\d]+@[\w\d]+\.[\w]+/
  VALID_NICKNAME = /\A\w+\z/
  VALID_COLOR = /\A#\h{3}{1,2}\z/

  has_secure_password

  before_save :downcase_nickname

  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL }
  validates :navbar_color, format: { with: VALID_COLOR }
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 40 }, format: { with: VALID_NICKNAME }

  private

  def downcase_nickname
    nickname&.downcase!
  end
end
