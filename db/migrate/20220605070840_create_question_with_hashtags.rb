class CreateQuestionWithHashtags < ActiveRecord::Migration[7.0]
  def change
    create_table :question_with_hashtags do |t|
      t.references :hashtag, foreign_key: true
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
