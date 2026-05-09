class Admin::UserActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    @activities = UserActivity.includes(:user).recent.limit(100)
  end
end
