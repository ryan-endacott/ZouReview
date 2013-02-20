class Course < ActiveRecord::Base

  belongs_to :department

  has_many :sections
  has_many :instructors, :through => :sections

  attr_accessible :number, :title

  validates_presence_of :number, :title

  def update_avg_gpa!

    num_sections = self.sections.count

    if num_sections > 0
      total_gpa = self.sections.sum(:avg_gpa)
      self.avg_gpa = total_gpa / num_sections
    else
      self.avg_gpa = 4.0
    end

    self.save!

  end

  private

  def avg_gpa=(val)
    super
  end


end
