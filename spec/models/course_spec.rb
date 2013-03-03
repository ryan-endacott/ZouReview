require 'spec_helper'

describe Course do
  it {should have_many :sections}
  it {should have_many(:instructors).through :sections}
  it {should belong_to :department}

  it {should validate_presence_of :title}
  it {should validate_presence_of :number}

  describe 'avg_gpa' do

    let(:course) { FactoryGirl.create(:course) }
    let(:section1) { FactoryGirl.create(:section, :avg_gpa => 3.5) }
    let(:section2) { FactoryGirl.create(:section, :avg_gpa => 3.2) }
    let(:avg_gpa) { 3.35 }

    describe 'update_avg_gpa!' do

      it 'should resave to database after calculating' do
        course.should_receive(:save!)
        course.update_avg_gpa!
      end


      it 'should correctly calculate gpa' do

        section1.course = course
        section2.course = course
        section1.save
        section2.save

        course.update_avg_gpa!

        course.avg_gpa.should == avg_gpa
      end


      it 'should set avg_gpa to 4.0 if no sections' do
        course.update_avg_gpa!
        course.avg_gpa.should == 4.0
      end


    end

    describe 'the attribute itself' do

      it 'should allow read' do
        expect { course.avg_gpa }.to_not raise_error
      end

      it 'should not allow write' do
        expect { course.avg_gpa = 3.5 }.to raise_error(NoMethodError)
      end

    end

  end

end
