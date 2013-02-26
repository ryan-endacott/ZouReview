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
    course = find_or_create_course!(department, section_data[:course_title], section_data[:course_number])
    instructor = find_or_create_instructor!(section_data[:instructor])
    section = find_or_create_section!(course, instructor, section_data)

    course.update_avg_gpa!

  end

  def find_or_create_department!(abbreviation)
    Rails.cache.fetch('department/' + abbreviation) do
      Department.where(:abbreviation => abbreviation).first_or_create
    end
  end

  def find_or_create_course!(department, title, number)
    Rails.cache.fetch('course/' + department.id.to_s + '/' + title + '/' + number) do
      Course.where(:title => title, :number => number, :department_id => department.id).first_or_create
    end
  end

  def find_or_create_section!(course, instructor, section_data)

    return Section.where(
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

  end

  def find_or_create_instructor!(name)
    return Instructor.where(:name => name).first_or_create
  end

end