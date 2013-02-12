class Section < ActiveRecord::Base

  belongs_to :course
  
  has_one :department, :through => :course

  attr_accessible :avg_gpa, :num_a, :num_b, :num_c, :num_d, :num_f, :number, :term

end
