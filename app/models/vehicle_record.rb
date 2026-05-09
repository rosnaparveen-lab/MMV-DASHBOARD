class VehicleRecord < ApplicationRecord
  self.abstract_class = true

  connects_to database: { writing: :vehicle, reading: :vehicle }
end
