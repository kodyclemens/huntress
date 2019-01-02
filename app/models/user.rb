class User < ActiveRecord::Base
  has_many :jobs
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
