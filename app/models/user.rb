class User < ApplicationRecord
  has_many :contacts
  has_many :documents

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
         include DeviseTokenAuth::Concerns::User

  validates :email, presence: true
  validates :email, uniqueness: true
end
