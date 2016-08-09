class Diver < ActiveRecord::Base
  has_many :dynamics
  has_many :statics

  has_secure_password
end
