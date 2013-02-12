require 'spec_helper'
require 'grade_data_importer'

describe GradeDataImporter do
  before(:all) do
    # Set up class_data to be used for all calls
    @class_data = [{
        :course_dept => 'HP',
        :course_title => 'PHYSICAL AGENTS',
        :course_number => '214',
        :section_number => '1',
        :term => 'WS2001',
        :course_au => 'HP',
        :instructor => 'ABBOTT',
        :count_a => 12,
        :count_b => 22,
        :count_c => 0,
        :count_d => 0,
        :count_f => 0,
        :avg_gpa => 3.353 },
      {
        :course_dept => 'HP',
        :course_title => 'PHYSICAL AGENTS',
        :course_number => '214',
        :section_number => '1',
        :term => 'WS2001',
        :course_au => 'HP',
        :instructor => 'John',
        :count_a => 12,
        :count_b => 2,
        :count_c => 0,
        :count_d => 5,
        :count_f => 8,
        :avg_gpa => 3.053
      }] 

    @length = @class_data.length
  end

  describe 'import_data' do

    it 'should call handle_class_section many (class_data.length) times' do
      GradeDataImporter.should_receive(:handle_section_data).exactly(@length).times
    end

    it 'should send each hash in class_data to handle_class_section' do
      @class_data.each do |section_data|
        GradeDataImporter.should_receive(:handle_section_data).with section_data
      end
    end

    after(:each) do
      # Call it with class data to do each test
      GradeDataImporter.import_data @class_data
    end
  end

  describe 'handle_class_section' do
    it 'still needs tests for handle_class_section'
  end

  it 'still needs tests written and TDD to happen!'

end