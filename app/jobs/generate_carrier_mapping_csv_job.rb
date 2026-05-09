class GenerateCarrierMappingCsvJob < ApplicationJob
  queue_as :default

  def perform(user_id, insurance_code, vehicle_type)
    download_dir = Rails.root.join("public/downloads")
    FileUtils.mkdir_p(download_dir)

    timestamp = Time.current.strftime("%Y%m%d_%H%M%S")
    csv_path = download_dir.join("carrier_mapping_#{timestamp}.csv")
    started_at = Time.current

    # Build query based on filters
    query = Vehicle::CarrierMap::TwoWheeler.includes(:two_wheeler)
    if insurance_code.present?
      query = query.where(insurance_code: insurance_code)
    end
    if vehicle_type.present?
      query = query.where(vehicle_type: vehicle_type)
    end

    records = query.all

    # Generate CSV
    csv_data = CSV.generate(headers: true) do |csv|
      headers = ['carrier_vehicle_name', 'carrier_vehicle_code', 'insurance_code',
                 'vehicle_code', 'vehicle_type', 'fuel_type', 'cubic_capacity',
                 'seating_capacity', 'carrier_make_code', 'additional_info', 'declain']
      csv << headers
      records.each do |record|
        csv << headers.map { |attr| record.send(attr) rescue nil }
      end
    end

    File.write(csv_path, csv_data)

    duration = Time.current - started_at
    download_log = DownloadLog.create!(
      user_id: user_id,
      downloaded_item: "Carrier Mapping CSV",
      downloaded_filename: csv_path.basename.to_s,
      duration_seconds: duration.round(2)
    )

    Rails.logger.info "Carrier Mapping CSV generated: #{csv_path} in #{duration.round(2)} seconds"
  rescue => e
    Rails.logger.error "Carrier Mapping CSV Job Error: #{e.message}"
  end
end