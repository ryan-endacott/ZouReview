class Section < ActiveRecord::Base

  belongs_to :course
  belongs_to :instructor

  has_one :department, :through => :course

  attr_accessible :avg_gpa, :num_a, :num_b, :num_c, :num_d, :num_f, :number, :term

  validates_presence_of :avg_gpa, :num_a, :num_b, :num_c, :num_d,
    :num_f, :number, :term, :course, :instructor

  validates :num_a, :num_b, :num_c, :num_d, :num_f, :numericality => {:only_integer => true}

  validates :avg_gpa, :numericality => true

end
