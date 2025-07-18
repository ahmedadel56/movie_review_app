class Location < ApplicationRecord
  has_and_belongs_to_many :movies

  validates :name, uniqueness: { case_sensitive: false }
end
