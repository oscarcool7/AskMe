class User < ApplicationRecord
  has_secure_password

  before_save :downcase_nickname

  validates :email, presence: true, uniqueness: true

  private

  def downcase_nickname
    nickname&.downcase!
  end
end
