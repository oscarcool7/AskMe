module QuestionsHelper
  def fill_question_with_hashtags!(text, question)
    matches = text.scan(/#[[:word:]]+/).flatten
    hashtags = matches.map { |m| Hashtag.find_or_create_by!(name: m.downcase) }
    question.hashtags << hashtags.uniq

    question
  end
end
