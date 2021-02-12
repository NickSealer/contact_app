class User < ApplicationRecord
  has_many :contacts

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true
end
