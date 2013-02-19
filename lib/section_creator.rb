# Class to take the crawled data params and import it to models
# for each section

class SectionCreator

  attr_accessor :section_data_array

  def initialize(section_data_array)
    @section_data_array = section_data_array
  end

  def create_sections!
    @section_data_array.each do |section_data|
      create_section! section_data
    end
  end

  def create_section!(section_data)

    department = find_or_create_department!(section_data[:course_dept])
    course = find_or_create_course!(section_data[:course_title], section_data[:course_number])
    instructor = find_or_create_instructor!(section_data[:instructor])

    associate_and_create_section!(section_data, department, course, instructor)

  end

  def find_or_create_department!(abbreviation)
    return Department.where(:abbreviation => abbreviation).first_or_create
  end

  def find_or_create_course!(title, number)
    return Course.where(:title => title, :number => number).first_or_create
  end

  def find_or_create_instructor!(name)
    return Instructor.where(:name => name).first_or_create
  end

  def associate_and_create_section!(section_data, department, course, instructor)

    section = Section.where(
      :number => section_data[:section_number],
      :term => section_data[:term],
      :num_a => section_data[:count_a],
      :num_b => section_data[:count_b],
      :num_c => section_data[:count_c],
      :num_d => section_data[:count_d],
      :num_f => section_data[:count_f],
      :avg_gpa => section_data[:avg_gpa],
      :course_id => course.id,
      :instructor_id => instructor.id
    ).first_or_create

    print 'SECTION ISSSSSSSSSSSSSSSSSSS'
    print section

    # Link up the last couple models!
    course.department = department
    course.save!

    instructor.sections << section
    instructor.save!

  end

end