class User < ApplicationRecord
  devise :database_authenticatable, :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first
    user ||= find_by(email: auth.info.email)

    user ||= create! do |u|
      u.provider = auth.provider
      u.uid = auth.uid
      u.email = auth.info.email
      u.password = Devise.friendly_token[0, 20]
      u.role = "user"
    end

    user
  end

  def admin?
    role == "admin"
  end
end
