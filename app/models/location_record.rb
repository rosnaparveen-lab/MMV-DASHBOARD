class LocationRecord < ApplicationRecord
  self.abstract_class = true

  connects_to database: { writing: :location, reading: :location }
end
