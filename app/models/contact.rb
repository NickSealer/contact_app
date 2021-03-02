class Contact < ApplicationRecord
  belongs_to :user
  # validates :name, format: {with: /\A [a-zA-Z] + \z/, message: "Invalid format"}

  scope :valid, -> { where(is_valid: true) }

end
