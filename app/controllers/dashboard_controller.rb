class DashboardController < ApplicationController
  def index
    @files = Dir.glob("public/downloads/*.csv").map { |f| File.basename(f) }.sort.reverse
    @recent_downloads = DownloadLog.includes(:user).order(created_at: :desc).limit(5)
  end
end
