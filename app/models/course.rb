class Course < ActiveRecord::Base

  belongs_to :department

  has_many :sections
  has_many :instructors, :through => :sections

  validates_presence_of :number, :title

  def update_avg_gpa!

    num_sections = sections.size

    if num_sections > 0
      total_gpa = sections.sum(:avg_gpa)
      self.avg_gpa = total_gpa / num_sections
    else
      self.avg_gpa = 4.0
    end

    save!

  end

  private

  def avg_gpa=(val)
    super
  end


end
