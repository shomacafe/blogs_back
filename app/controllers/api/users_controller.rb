class Api::UsersController < ApplicationController
  before_action :authenticate_api_user!

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def update_profile
    @user = current_api_user

    if @user.update(profile_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_account
    @user = current_api_user

    if params[:email].present?
      unless @user.valid_password?(params[:current_password])
        render json: { errors: ['現在のパスワードが正しくありません'] }, status: :unprocessable_entity
        return
      end
    end

    if @user.update(account_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name, :image, :profile)
  end

  def account_params
    params.permit(:email, :password, :password_confirmation)
  end

end
