class UserActivity < ApplicationRecord
  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

  def self.log(user, action, details = {}, ip = nil)
    create!(
      user: user,
      action: action,
      details: details.to_json,
      ip_address: ip || "unknown"
    )
  end
end
