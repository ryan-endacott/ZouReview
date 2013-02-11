class Course < ActiveRecord::Base

  belongs_to :department

  attr_accessible :number, :title

end
