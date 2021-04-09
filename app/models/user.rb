# frozen_string_literal: true

# User model definition
class User < ApplicationRecord
  has_many :contacts
  has_many :documents

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  validates :email, presence: true, uniqueness: { scope: :provider }
end
