class Employee < ApplicationRecord
  has_secure_password
  has_many :work_histories, dependent: :destroy
  accepts_nested_attributes_for :work_histories, allow_destroy: true

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
end
