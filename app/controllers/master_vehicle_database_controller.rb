class MasterVehicleDatabaseController < ApplicationController
  def index
    @pagy, @vehicles = pagy(Vehicle::CarrierMap::TwoWheeler.all, items: 50)
    @total_count = Vehicle::CarrierMap::TwoWheeler.count
  end
end
