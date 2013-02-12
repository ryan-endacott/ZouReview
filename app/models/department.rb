class Department < ActiveRecord::Base

  has_many :courses
  has_many :sections, :through => :courses

  attr_accessible :name

end
