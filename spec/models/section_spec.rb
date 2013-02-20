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

  describe 'update_course_avg_gpa!' do

    let(:section) { FactoryGirl.create(:section) }

    it 'should call course.update_avg_gpa!' do
      section.course.should_receive(:update_avg_gpa!)
      section.update_course_avg_gpa!
    end

    it 'should be called after save' do
      section.should_receive(:update_course_avg_gpa!)
      section.save!
    end

  end

end
