class RtoLocationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @pagy, @rto_locations = pagy(Vehicle::CarrierMap::RtoLocation.all, items: 50)
  end

  def export
    @rto_locations = Vehicle::CarrierMap::RtoLocation.all

    send_data @rto_locations.to_csv,
              filename: "rto_locations_#{Date.today}.csv",
              type: "text/csv"
  end
end
