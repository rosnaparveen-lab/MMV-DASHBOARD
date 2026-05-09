class Users::SessionsController < Devise::SessionsController
  # Custom logout action
  def destroy
    # Log the logout activity
    UserActivity.log(current_user, "logout", { method: "manual" }, request.remote_ip) if user_signed_in?

    # Perform Devise logout
    super
  end

  protected

  # Redirect to login page after logout
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
