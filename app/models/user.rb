class User < ActiveRecord::Base
  has_many :jobs
  has_secure_password
  validates :username, presence: true, uniqueness: true, on: :create
  validates :email, presence: true, uniqueness: true, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create
end
