module Vehicle
  module CarrierMap
    class RtoLocation < ApplicationRecord
      self.table_name = 'rto_locations'

      def self.to_csv
        CSV.generate(headers: true) do |csv|
          attributes = column_names
          csv << attributes

          all.each do |record|
            csv << attributes.map { |attr| record.send(attr) }
          end
        end
      end
    end
  end
end
