class Section < ActiveRecord::Base

  belongs_to :course
  belongs_to :instructor

  has_one :department, :through => :course

  validates_presence_of :avg_gpa, :num_a, :num_b, :num_c, :num_d,
    :num_f, :number, :term

  # This validation must be used instead of validates_presence_of (course or instructor)
  # Because when creating with Section.where(:course_id => 1).first_or_create, it would
  # Fails and be invalid because no real 'course' supplied
  validate :course_or_course_id
  validate :instructor_or_instructor_id

  validates :num_a, :num_b, :num_c, :num_d, :num_f, :numericality => {:only_integer => true}

  validates :avg_gpa, :numericality => true

  private

  def course_or_course_id
    if !(course_id || course)
      errors.add(:course, 'Section must have a course or course_id.')
    end
  end

  def instructor_or_instructor_id
    if !(instructor_id || instructor)
      errors.add(:instructor, 'Section must have an instructor or instructor_id.')
    end
  end

end
