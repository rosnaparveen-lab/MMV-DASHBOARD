class ClaimRecord < ApplicationRecord
  self.abstract_class = true
  connects_to database: { writing: :claim, reading: :claim }
end
