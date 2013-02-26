require 'spec_helper'
require 'section_creator'

describe SectionCreator do

  # Sample crawled data
  let!(:sections) { FactoryGirl.build_list(:crawled_data, 10) }
  let(:example_section) { sections.first }

  let(:department) { FactoryGirl.create(:department) }
  let(:course) { FactoryGirl.create(:course) }
  let(:instructor) { FactoryGirl.create(:instructor) }
  let(:section) { FactoryGirl.create(:section) }

  subject { SectionCreator.new(sections) }

  describe 'initialize' do
    its(:section_data_array) { should == sections }
  end

  describe 'create_sections!' do

    before(:each) do
      subject.stub(:create_section!)
    end

    it 'should call create_section! on each section' do
      sections.each do |section|
        subject.should_receive(:create_section!).with(section)
      end
    end

    after(:each) do
      subject.create_sections!
    end

  end

  describe 'create_section!' do


    # Associate the factories beforehand just like
    # This test seems too dependent on implementation and bad.
    # I'll have to look into how to fix it
    before(:all) do
      course.department_id = department.id
      section.course_id = course.id
      section.instructor_id = instructor.id

      section.save!
      course.save!
    end

    # Stub out the calls and return proper factories
    before(:each) do
      subject.stub(:find_or_create_department!).and_return department
      subject.stub(:find_or_create_course!).and_return course
      subject.stub(:find_or_create_instructor!).and_return instructor
      subject.stub(:find_or_create_section!).and_return section
      course.stub(:update_avg_gpa!)
    end

    context 'testing implementation' do

      it 'should call find_or_create_department!' do
        subject
          .should_receive(:find_or_create_department!)
          .with(example_section[:course_dept])
      end

      it 'should call find_or_create_course!' do
        subject
          .should_receive(:find_or_create_course!)
          .with(department, example_section[:course_title], example_section[:course_number])
      end

      it 'should call find_or_create_instructor!' do
        subject
          .should_receive(:find_or_create_instructor!)
          .with(example_section[:instructor])
      end

      it 'should call find_or_create_section!' do
        subject
          .should_receive(:find_or_create_section!)
          .with(course, instructor, example_section)
      end

      it 'should call course.update_avg_gpa!' do
        course.should_receive(:update_avg_gpa!)
      end

      after(:each) do
        subject.create_section!(example_section)
      end

    end

    context 'testing associations' do


      context 'department assocation' do

        it 'to course' do
          department.courses.should include(course)
        end

        it 'to instructor' do
          department.instructors.should include(instructor)
        end

        it 'to section' do
          department.sections.should include(section)
        end

      end

      context 'course association' do

        it 'to department' do
          course.department.should == department
        end

        it 'to instructor' do
          course.instructors.should include(instructor)
        end

        it 'to section' do
          course.sections.should include(section)
        end

      end

      context 'instructor association' do

        it 'to department' do
          instructor.departments.should include(department)
        end

        it 'to course' do
          instructor.courses.should include(course)
        end

        it 'to section' do
          instructor.sections.should include(section)
        end

      end

      context 'section association' do

        it 'to department' do
          section.department.should == department
        end

        it 'to course' do
          section.course.should == course
        end

        it 'to instructor' do
          section.instructor.should == instructor
        end

      end

    end

  end

  describe 'find_or_create_department!' do

    before(:each) do
      Department.stub(:where).and_return department
      department.stub(:first_or_create).and_return department
    end
 
    context 'cached' do

      before(:all) do
        Rails.cache.write('department/' + example_section[:course_dept], department)
      end

      it 'should not call department' do
        Department.should_not_receive(:where)
      end

      it 'should return a department' do
        subject.find_or_create_department!(example_section[:course_dept])
          .should == department
      end

    end

    context 'uncached' do

      before(:each) do
        Rails.cache.clear
      end

      it 'should call Department.where with proper params' do
        Department.should_receive(:where).with(:abbreviation => example_section[:course_dept])
      end

      it 'should call Department.first_or_create' do
        department.should_receive(:first_or_create)
      end

      it 'should return a department' do
        subject.find_or_create_department!(example_section[:course_dept])
          .should == department
      end

    end

    after(:each) do 
      subject.find_or_create_department!(example_section[:course_dept])
    end

  end

  describe 'find_or_create_course!' do

    before(:each) do
      Course.stub(:where).and_return course
      course.stub(:first_or_create).and_return course
    end

    context 'cached' do

      before(:all) do
        Rails.cache.write(
          'course/' + department.id.to_s + '/' + example_section[:course_title] + '/' + example_section[:course_number],
          course)
      end

      it 'should not call course' do
        Course.should_not_receive(:where)
      end

      it 'should return a course' do
        subject.find_or_create_course!(department, example_section[:course_title], example_section[:course_number])
          .should == course
      end

    end

    context 'uncached' do

      before(:each) do
        Rails.cache.clear
      end

      it 'should call Course.where with proper params' do
        Course.should_receive(:where)
          .with(
            :title => example_section[:course_title],
            :number => example_section[:course_number],
            :department_id => department.id
          )
      end

      it 'should call Course.first_or_create' do
        course.should_receive(:first_or_create)
      end

      it 'should return a course' do
        subject.find_or_create_course!(department, example_section[:course_title], example_section[:course_number])
          .should == course
      end

    end

    after(:each) do
      subject.find_or_create_course!(department, example_section[:course_title], example_section[:course_number])
    end


  end


  describe 'find_or_create_section!' do

    before(:each) do
      Section.stub(:where).and_return section
      section.stub(:first_or_create).and_return section
    end

    it 'should return a section' do
      subject.find_or_create_section!(course, instructor, example_section)
        .should == section
    end

    context 'inner method logic' do

      it 'should call Section.where with proper params' do
        Section.should_receive(:where)
          .with(
            :number => example_section[:section_number],
            :term => example_section[:term],
            :num_a => example_section[:count_a],
            :num_b => example_section[:count_b],
            :num_c => example_section[:count_c],
            :num_d => example_section[:count_d],
            :num_f => example_section[:count_f],
            :avg_gpa => example_section[:avg_gpa],
            :course_id => course.id,
            :instructor_id => instructor.id
          )
      end

      it 'should call Section.first_or_create' do
        section.should_receive(:first_or_create)
      end

      after(:each) do
        subject.find_or_create_section!(course, instructor, example_section)
      end

    end

  end


  describe 'find_or_create_instructor!' do

    before(:each) do
      Instructor.stub(:where).and_return instructor
      instructor.stub(:first_or_create).and_return instructor
    end

    it 'should return a instructor' do
      subject.find_or_create_instructor!(example_section[:instructor])
        .should == instructor
    end

    context 'inner method logic' do

      it 'should call Instructor.where with proper params' do
        Instructor.should_receive(:where)
          .with(:name => example_section[:instructor])
      end

      it 'should call Instructor.first_or_create' do
        instructor.should_receive(:first_or_create)
      end

      after(:each) do
        subject.find_or_create_instructor!(example_section[:instructor])
      end

    end

  end

end