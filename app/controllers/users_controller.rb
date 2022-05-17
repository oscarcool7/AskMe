class UsersController < ApplicationController
  def create
    user_params = params.require(:user).permit(:name, :nickname, :email, :password)

    User.create(user_params)

    redirect_to root_path, notice: "Вы успешно зарегистрировались!"
  end

  def new
  end
end
