class ApplicationController < ActionController::Base

  include Pagy::Backend

  before_action :authenticate_user!,
                unless: :devise_controller?

  before_action :log_user_activity,
                if: :user_signed_in?

  private

  def log_user_activity
    action = "#{controller_name}##{action_name}"

    details = {
      path: request.fullpath,
      method: request.method
    }

    UserActivity.log(
      current_user,
      action,
      details,
      request.remote_ip
    )
  end

  def require_admin!
    unless current_user&.admin?
      redirect_to root_path,
                  alert: "Access denied. Admins only."
    end
  end

end
