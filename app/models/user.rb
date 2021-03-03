class User < ApplicationRecord
  has_many :contacts
  has_many :csv_files

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :email
  validates :email, uniqueness: true
end
