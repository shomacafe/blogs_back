class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::Cookies

  before_action do
    I18n.locale = :ja
  end

  skip_before_action :verify_authenticity_token
  helper_method :current_user, :user_signed_in?
end
