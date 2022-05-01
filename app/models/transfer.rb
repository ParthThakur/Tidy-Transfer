class Transfer < ApplicationRecord
  validates :sharable_link, uniqueness: true, allow_nil: true
  belongs_to :user

  has_one_attached :file, dependent: :delete_all
  validates :file,
            file_size: { less_than: 1025.megabytes , message: 'File size must be less than 1GB.' }
end
