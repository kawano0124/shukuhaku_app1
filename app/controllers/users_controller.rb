# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @user = current_user
  end

  def edit_profile
    @user = current_user
  end

  def update_profile
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: 'プロフィールが更新されました'
    else
      render :edit_profile
    end
  end

  private

  def user_params
    params.require(:user).permit(:icon_image, :name, :introduction)
  end
end
