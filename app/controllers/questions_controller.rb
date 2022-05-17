class QuestionsController < ApplicationController
  before_action :ensure_current_user, only: %i[destroy edit update]
  before_action :set_question, only: %i[edit destroy show update]

  def create
    question_params = params.require(:question).permit(:body, :user_id)
    question = Question.create(question_params)

    redirect_to user_path(@question.user), notice: "Новый вопрос создан!"
  end

  def edit
  end

  def destroy
    @user = @question.user
    @question.destroy

    redirect_to user_path(@user), notice: "Вопрос удалён!"
  end

  def index
    @question = Question.new
    @questions = Question.all
  end

  def new
    @user = User.find(params[:user_id])
    @question = Question.new(user: @user)
  end

  def show
    @question = Question.find(params[:id])
  end

  def update
    question_params = params.require(:question).permit(:body, :answer)
    @question.update(question_params)

    redirect_to user_path(@question.user), notice: "Сохранили вопрос!"
  end

  private

  def ensure_current_user
    redirect_with_alert unless current_user.present?
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
