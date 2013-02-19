require 'spec_helper'

describe Course do
  it {should have_many :sections}
  it {should have_many(:instructors).through :sections}
  it {should belong_to :department}

  it {should validate_presence_of :title}
  it {should validate_presence_of :number}

  describe 'calculate_avg_gpa!' do

    let!(:course) { FactoryGirl.create(:course) }
    let(:section1) { FactoryGirl.create(:section, :course_id => course.id, :avg_gpa => 3.5) }
    let(:section2) { FactoryGirl.create(:section, :course_id => course.id, :avg_gpa => 3.2) }
    let(:avg_gpa) { 3.35 }

    before(:each) do
      course.calculate_avg_gpa!
    end

    it 'should correctly calculate gpa' do
      course.avg_gpa.should == avg_gpa
    end

    it 'should resave to database after calculating' do
      Course.find(course).avg_gpa.should == avg_gpa
    end

  end

end
