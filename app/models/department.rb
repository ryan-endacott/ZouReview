class Department < ActiveRecord::Base

  has_many :courses

  attr_accessible :name

end
