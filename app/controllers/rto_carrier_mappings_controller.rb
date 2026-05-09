class RtoCarrierMappingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @carrier_mappings = Vehicle::CarrierMap::RtoLocation.all

    # Filter by insurance_code
    if params[:insurance_code].present?
      @carrier_mappings = @carrier_mappings.where(insurance_code: params[:insurance_code])
    end

    @pagy, @carrier_mappings = pagy(@carrier_mappings, items: 50)
    @insurances = Vehicle::CarrierMap::RtoLocation.pluck(:insurance_code).uniq.compact
  end

  def export
    @carrier_mappings = Vehicle::CarrierMap::RtoLocation.all
    if params[:insurance_code].present?
      @carrier_mappings = @carrier_mappings.where(insurance_code: params[:insurance_code])
    end

    send_data @carrier_mappings.to_csv,
              filename: "rto_carrier_mappings_#{Date.today}.csv",
              type: "text/csv"
  end
end
