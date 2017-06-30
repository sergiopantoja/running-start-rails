# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  api_key                :string
#  name                   :string
#  admin                  :boolean          default(FALSE), not null
#  time_zone              :string           default("Eastern Time (US & Canada)"), not null
#  last_seen_at           :datetime
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  has_paper_trail

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  before_validation :normalize
  before_save :ensure_api_key

  def first_name
    name.split(' ').first
  end

  def last_name
    name.split(' ').last
  end

  def ensure_api_key
    if api_key.blank?
      self.api_key = generate_api_key
    end
  end

  private

  def normalize
    self.email = email.downcase if email
    self.name = name.titleize if name
  end

  def generate_api_key
    loop do
      key = Devise.friendly_token
      break key unless User.where(api_key: key).first
    end
  end
end
