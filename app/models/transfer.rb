class Transfer < ApplicationRecord
  validates :sharable_link, uniqueness: true, allow_nil: true
  belongs_to :user
  has_one_attached :file
end
