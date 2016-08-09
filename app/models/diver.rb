class Diver < ActiveRecord::Base
  has_many :dynamics
  has_many :statics
end
