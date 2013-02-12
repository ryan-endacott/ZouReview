class Instructor < ActiveRecord::Base

  has_many :sections
  has_many :courses, :through => :sections
  has_many :departments, :through => :courses

  attr_accessible :name

  validates_presence_of :name
  
end
