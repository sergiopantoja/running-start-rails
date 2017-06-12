class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :null_session
  before_action :authenticate_user_from_api_key!
  before_action :authenticate_user!
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

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
end
