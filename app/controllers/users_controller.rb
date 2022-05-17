class UsersController < ApplicationController
  before_action :set_user, only: %i[edit destroy show update]
  before_action :authorize_user, only: %i[edit destroy update]

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id

      redirect_to root_path, notice: "Вы успешно зарегистрировались!"
    else
      flash.now[:alert] = "Вы неправильно заполнили поля формы регистрации!"

      render :new
    end
  end

  def destroy
    @user.destroy

    session.delete(:user_id)

    redirect_to root_path, notice: "Пользователь удалён"
  end

  def edit
  end

  def new
    session[:current_time] = Time.now
    @user = User.new
  end

  def show
    @questions = @user.questions.order(created_at: :desc)
    @question = Question.new(user: @user)
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "Данные пользователя обновлены"
    else
      flash.now[:alert] = "При попытке сохранить пользователя возникли ошибки"

      render :edit
    end
  end

  private

  def authorize_user
    redirect_with_alert unless current_user == @user
  end

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation, :navbar_color)
  end
end
