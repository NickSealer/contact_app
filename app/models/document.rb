# frozen_string_literal: true

# Document model definition
class Document < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  validates :name, :status, presence: true
end
