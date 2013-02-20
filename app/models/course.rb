class Course < ActiveRecord::Base

  belongs_to :department

  has_many :sections
  has_many :instructors, :through => :sections

  attr_accessible :number, :title
  attr_reader :avg_gpa

  validates_presence_of :number, :title

  def update_avg_gpa!

    num_sections = self.sections.count

    if num_sections > 0
      total_gpa = self.sections.sum(:avg_gpa)
      @avg_gpa = total_gpa / num_sections
    else
      @avg_gpa = 4.0
    end
    
    self.save!

  end

end
