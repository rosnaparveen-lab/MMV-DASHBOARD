class HomebizRecord < ApplicationRecord
  self.abstract_class = true
  connects_to database: { writing: :homebiz, reading: :homebiz }
end
