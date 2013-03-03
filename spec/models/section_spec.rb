require 'spec_helper'

describe Section do
  it {should belong_to :instructor}
  it {should belong_to :course}
  it {should have_one :department}

  it {should validate_presence_of :num_a}
  it {should validate_presence_of :num_b}
  it {should validate_presence_of :num_c}
  it {should validate_presence_of :num_d}
  it {should validate_presence_of :num_f}
  it {should validate_presence_of :avg_gpa}
  it {should validate_presence_of :number}
  it {should validate_presence_of :term}

  it {should validate_numericality_of(:num_a).only_integer}
  it {should validate_numericality_of(:num_b).only_integer}
  it {should validate_numericality_of(:num_c).only_integer}
  it {should validate_numericality_of(:num_d).only_integer}
  it {should validate_numericality_of(:num_f).only_integer}
  it {should validate_numericality_of :avg_gpa}

  # These ended up necessary because of where clause with a first_or_create
  # not validating because there was no 'course', only a course_id

  context 'validate presence of course or course_id' do
    let(:section) { FactoryGirl.build(:section, :course => nil) }
    let(:course) { FactoryGirl.build(:course) }

    it 'the original let clause should be invalid' do
      section.should_not be_valid
    end

    it 'should validate with just a course_id' do
      section.course_id = 1
      section.should be_valid
    end

    it 'should validate with just a course' do
      section.course = course
      section.should be_valid
    end

  end

  context 'validate presence of instructor or instructor_id' do
    let(:section) { FactoryGirl.build(:section, :instructor => nil) }
    let(:instructor) { FactoryGirl.build(:instructor) }

    it 'the original let clause should be invalid' do
      section.should_not be_valid
    end

    it 'should validate with just an instructor_id' do
      section.instructor_id = 1
      section.should be_valid
    end

    it 'should validate with just an instructor' do
      section.instructor = instructor
      section.should be_valid
    end

  end

end
