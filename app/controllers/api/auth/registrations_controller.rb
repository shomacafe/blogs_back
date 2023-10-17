class Api::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  private

  def sign_up_params
    params.require(:registration).permit(:name, :email, :password, :password_confirmation, :profile)
  end
end
