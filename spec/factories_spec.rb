require 'spec_helper'
# Tests my factories to make sure I set up associations correctly

describe 'Alll of the factories!!' do

  describe 'Department Factory' do

    let(:department) {FactoryGirl.build(:department)}

    it 'should have a default name' do
      department.name.should_not be_nil
    end

    it 'should have a default abbr' do
      department.abbreviation.should_not be_nil
    end

    it 'should be valid' do
      department.should be_valid
    end

  end

  describe 'Course Factory' do

    let(:course) {FactoryGirl.build(:course)}

    it 'should have default title' do
      course.title.should_not be_nil
    end

    it 'should have a default number' do
      course.number.should_not be_nil
    end

    it 'should be valid' do
      course.should be_valid
    end

  end

  describe 'Section Factory' do

    let(:section) {FactoryGirl.build(:section)}

    it 'should have a number' do
      section.number.should_not be_nil
    end

    it 'should have a term' do
      section.term.should_not be_nil
    end

    it 'should have grade counts' do
      section.num_a.should_not be_nil
      section.num_b.should_not be_nil
      section.num_c.should_not be_nil
      section.num_d.should_not be_nil
      section.num_f.should_not be_nil
    end

    it 'should have an average gpa' do
      section.avg_gpa.should_not be_nil
    end

    it 'should be valid' do
      pending 'I think I am going to remove the validate presence of course and instructor'
    end

  end

  describe 'Instructor Factory' do

    let(:instructor) {FactoryGirl.build(:instructor)}

    it 'should have a default name' do
      instructor.name.should_not be_nil
    end

    it 'should be valid' do
      instructor.should be_valid
    end

  end
  
end