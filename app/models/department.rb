class Department < ActiveRecord::Base

  has_many :courses
  has_many :sections, :through => :courses
  has_many :instructors, :through => :sections

  attr_accessible :name

end
