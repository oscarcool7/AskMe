class QuestionsController < ApplicationController
  before_action :ensure_current_user, only: %i[edit destroy update]
  before_action :set_question_for_current_user, only: %i[edit destroy update]

  def create
    question_params = params.require(:question).permit(:body, :user_id)

    @question = Question.new(question_params)
    @question.author = current_user

    @question = fill_question_with_hashtags_from_body!(@question)

    if check_captcha(@question) && @question.save
      redirect_to user_path(@question.user), notice: "Новый вопрос создан!"
    else
      flash.now[:alert] = "Вы неправильно заполнили поле вопроса!"

      render "new"
    end
  end

  def edit
  end

  def destroy
    @user = @question.user
    @question.destroy

    redirect_to user_path(@user), notice: "Вопрос удалён!"
  end

  def index
    @hashtags = Hashtag.all.limit(10)
    @questions = Question.order(created_at: :desc).last(10)
    @users = User.order(created_at: :desc).last(10)
  end

  def new
    @user = User.friendly.find(params[:user_id])
    @question = Question.new(user: @user)
  end

  def show
    @question = Question.find(params[:id])
  end

  def update
    question_params = params.require(:question).permit(:body, :answer)
    @question = fill_question_with_hashtags_from_answer!(question_params[:answer], @question)
    @question.update(question_params)

    redirect_to user_path(@question.user), notice: "Сохранили вопрос!"
  end

  private

  def check_captcha(model)
    current_user.present? || verify_recaptcha(model: model)
  end

  def ensure_current_user
    redirect_with_alert unless current_user.present?
  end

  def fill_question_with_hashtags_from_body!(question)
    body = question.body
    matches = body.scan(/#[[:word:]]+/).flatten
    hashtags = matches.map { |m| Hashtag.find_or_create_by!(name: m.downcase) }
    question.hashtags << hashtags.uniq

    question
  end

  def fill_question_with_hashtags_from_answer!(answer, question)
    matches = answer.scan(/#[[:word:]]+/).flatten
    hashtags = matches.map { |m| Hashtag.find_or_create_by!(name: m.downcase) }
    question.hashtags << hashtags.uniq

    question
  end

  def set_question_for_current_user
    @question = current_user.questions.find(params[:id])
  end
end
