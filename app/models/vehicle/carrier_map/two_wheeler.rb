module Vehicle
  module CarrierMap
    class TwoWheeler < ApplicationRecord
      self.table_name = 'carrier_map_two_wheelers'

      belongs_to :two_wheeler, optional: true

      scope :apply_filters, ->(params) {
        query = all
        if params[:insurance_code].present?
          query = query.where(insurance_code: params[:insurance_code])
        end
        if params[:vehicle_type].present?
          query = query.where(vehicle_type: params[:vehicle_type])
        end
        query
      }

      scope :vehicle_search, ->(name) {
        return all if name.blank?
        where('carrier_vehicle_name ILIKE ?', "%#{name}%")
      }

      def self.carrier_csv
        CSV.generate(headers: true) do |csv|
          headers = ['carrier_vehicle_name', 'carrier_vehicle_code', 'insurance_code',
                     'vehicle_code', 'vehicle_type', 'fuel_type', 'cubic_capacity',
                     'seating_capacity', 'carrier_make_code', 'additional_info', 'declain']
          csv << headers
          all.each do |record|
            csv << headers.map { |attr| record.send(attr) rescue nil }
          end
        end
      end
    end
  end
end