class Currency < ApplicationRecord
  validates :symbol, presence: true, uniqueness: true
end
