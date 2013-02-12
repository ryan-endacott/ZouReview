class Instructor < ActiveRecord::Base

  has_many :sections
  has_many :courses, :through => :sections

  attr_accessible :name

end
