class VehicleCarrierMappingController < ApplicationController
  before_action :set_carrier_map_two_wheeler, only: [:show, :edit, :update, :destroy]

  # GET /carrier_mapping
  def index
    two_wheeler = Vehicle::CarrierMap::TwoWheeler.includes(:two_wheeler)
    @carrier_map_two_wheelers = two_wheeler.apply_filters(params).vehicle_search(params[:name])
    if request.format.symbol != :csv
      @insurances = two_wheeler.pluck(:insurance_code).uniq.compact
      @lob_mapping_hash = @carrier_map_two_wheelers.group(:vehicle_type).count
      @pagy, @carrier_map_two_wheelers = pagy(@carrier_map_two_wheelers, items: params.fetch(:per_page, 50).to_i)
    end
    respond_to do |format|
      format.html
      format.js { render layout: false, content_type: 'text/javascript' }
      format.csv { send_data @carrier_map_two_wheelers.carrier_csv, filename: 'carrier_map_two_wheelers-' + Date.today.to_s + '.csv' }
    end
  end

  # GET /carrier_mapping/1
  def show
  end

  # GET /carrier_mapping/new
  def new
    @carrier_map_two_wheeler = Vehicle::CarrierMap::TwoWheeler.new
  end

  # GET /carrier_mapping/1/edit
  def edit
  end

  def mapper
    # respond_to do |format|
    #   format.html
    #   format.js { render layout: false, content_type: 'text/javascript' }
    # end
  end

  def vehicles
    two_wheeler = Vehicle::CarrierMap::TwoWheeler.includes(:two_wheeler)
    @carrier_map_two_wheelers = two_wheeler.apply_filters(params).vehicle_search(params[:name])
    if request.format.symbol != :csv
      @insurances = two_wheeler.pluck(:insurance_code).uniq.compact
      @lob_mapping_hash = @carrier_map_two_wheelers.group(:vehicle_type).count
      @carrier_map_two_wheelers = @carrier_map_two_wheelers&.page(params.fetch(:page, 1))&.per(params.fetch(:per_page, 50))
    end
    respond_to do |format|
      format.html
      format.js { render layout: false, content_type: 'text/javascript' }
      format.csv { send_data @carrier_map_two_wheelers.carrier_csv, filename: 'carrier_map_two_wheelers-' + Date.today.to_s + '.csv' }
    end
  end

  # POST /carrier_mapping
  def create
    @carrier_map_two_wheeler = Vehicle::CarrierMap::TwoWheeler.new(carrier_map_two_wheeler_params)

    if @carrier_map_two_wheeler.save
      redirect_to @carrier_map_two_wheeler, notice: 'Two wheeler was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /carrier_mapping/1
  def update
    if @carrier_map_two_wheeler.update(carrier_map_two_wheeler_params)
      redirect_to @carrier_map_two_wheeler, notice: 'Two Wheeler was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /carrier_mapping/1
  def destroy
    @carrier_map_two_wheeler.destroy
    redirect_to vehicles_vehicle_carrier_mapping_index_path, notice: 'Two Wheeler was successfully destroyed.'
  end

  def export
    # For large data, use background job
    if params[:insurance_code].present? || params[:vehicle_type].present?
      # Filtered download
      GenerateCarrierMappingCsvJob.perform_later(current_user.id, params[:insurance_code], params[:vehicle_type])
    else
      # All data - large, use job
      GenerateCarrierMappingCsvJob.perform_later(current_user.id, nil, nil)
    end
    flash[:notice] = "CSV generation started! Download will be available soon."
    redirect_to vehicle_carrier_mapping_index_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carrier_map_two_wheeler
      @carrier_map_two_wheeler = Vehicle::CarrierMap::TwoWheeler.find(params[:id])
    end

    def carrier_map_two_wheeler_params
      params.require(:vehicle_carrier_map_two_wheeler).permit(:two_wheeler_id, :code, :insurance_code, :enable, :name, :make_code, :model_code, :variant_code, :fuel_type, :cc, :seating_capacity, :vehicle_type, :carrier_make_code)
    end
end
