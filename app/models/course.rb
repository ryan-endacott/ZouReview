class Course < ActiveRecord::Base

  belongs_to :department

  has_many :sections
  has_many :instructors, :through => :sections

  attr_accessible :number, :title

end
