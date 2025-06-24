class Actor < ApplicationRecord
  has_and_belongs_to_many :movies

  validates :name, uniqueness: { case_sensitive: false }
  # Allow searching by name and other safe attributes
  def self.ransackable_attributes(auth_object = nil)
    [ "name", "id" ]
  end

  # Allow searching through associated movies (optional)
  def self.ransackable_associations(auth_object = nil)
    [ "movies" ]
  end
end
