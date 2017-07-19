class Listing < ApplicationRecord
  belongs_to :user
  mount_uploaders :image, ImageUploader
  has_many :reservations

  filterrific(
  default_filter_params: { sorted_by: 'created_at' },
  available_filters: [
    :sorted_by,
    :search_query,
    :with_country,
    :with_created_at
  ]
)
end
