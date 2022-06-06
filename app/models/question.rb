class Question < ApplicationRecord
  belongs_to :author, class_name: "User", optional: true
  belongs_to :user
  has_many :question_with_hashtags, dependent: :destroy
  has_many :hashtags, through: :question_with_hashtags

  after_save_commit :update_hashtags

  validates :body, presence: true, length: { maximum: 280 }

  private

  def scan_hashtags(text)
    text.scan(/#[[:word:]]+/)
  end

  def question_hashtags
    question_text = "#{body} #{answer}"
    scan_hashtags(question_text.downcase).uniq
  end

  def update_hashtags
    self.hashtags = question_hashtags.map { |tag| Hashtag.find_or_create_by(name: tag) }
  end
end
