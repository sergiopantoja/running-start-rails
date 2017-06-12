class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :null_session
  before_action :authenticate_user_from_api_key!
  before_action :authenticate_user!
  after_action :verify_authorized, except: :index, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def authenticate_user_from_api_key!
    email = request.headers['X-Api-Email'].presence
    key   = request.headers['X-Api-Key'].presence
    user  = User.find_by(email: email)

    if email && key && user && Devise.secure_compare(user.api_key, key)
      env['devise.skip_trackable'] = true
      sign_in user, store: false
    end
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
