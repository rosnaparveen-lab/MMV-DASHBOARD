class Admin::DownloadLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    @pagy, @logs = pagy(
      DownloadLog.includes(:user).order(created_at: :desc),
      items: 25
    )
  end

  private

  def require_admin!
    redirect_to root_path, alert: "Access denied!" unless current_user.admin?
  end
end
