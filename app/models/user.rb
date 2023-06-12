class User < ApplicationRecord
  has_secure_password
  encrypts :api_key, deterministic: true
  validates_presence_of :email
  validates_presence_of :password
  validates_uniqueness_of :email
  validates_uniqueness_of :api_key
end