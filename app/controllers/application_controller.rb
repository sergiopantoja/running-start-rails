class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :null_session

  before_action :authenticate_user_from_api_key!
  before_action :authenticate_user!
  before_action :update_last_seen_at, if: :user_signed_in?
  before_action :set_paper_trail_whodunnit
  around_action :set_time_zone, if: :current_user
  after_action :verify_authorized, except: :index, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end

  def update_last_seen_at
    current_user.update_column(:last_seen_at, Time.current)
  end

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
