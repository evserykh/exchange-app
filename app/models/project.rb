class Project < ApplicationRecord
  validates :api_key, presence: true, uniqueness: true
end
