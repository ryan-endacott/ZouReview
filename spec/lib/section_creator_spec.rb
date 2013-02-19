require 'spec_helper'
require 'section_creator'

describe SectionCreator do

  # Sample crawled data
  let!(:sections) { FactoryGirl.build_list(:crawled_data, 10) }
  let(:example_section) { sections.first }

  let(:department) { FactoryGirl.build(:department) }
  let(:course) { FactoryGirl.build(:course) }
  let(:instructor) { FactoryGirl.build(:instructor) }
  let(:section) { FactoryGirl.build(:section) }

  subject { SectionCreator.new(sections) }

  describe 'initialize' do
    its(:sections) { should == sections }
  end

  describe 'create_sections!' do

    before(:all) do
      subject.stub(:create_section!)
    end

    it 'should call create_section! on each section' do
      sections.each do |section|
        subject.should_receive(:create_section!).with(section)
      end
    end

    after(:all) do
      subject.create_sections!
    end

  end

  describe 'create_section!' do


    before(:all) do
      subject.stub(:find_or_create_department!).and_return department
      subject.stub(:find_or_create_course!).and_return course
      subject.stub(:find_or_create_instructor!).and_return instructor
      subject.stub(:associate_and_create_section!)
    end

    it 'should call find_or_create_department!' do
      subject
        .should_receive(:find_or_create_department!)
        .with(example_section[:course_dept])
    end

    it 'should call find_or_create_course!' do
      subject
        .should_receive(:find_or_create_course!)
        .with(example_section[:course_title], example_section[:course_number])
    end

    it 'should call find_or_create_instructor!' do
      subject
        .should_receive(:find_or_create_instructor!)
        .with(example_section[:instructor])
    end

    it 'should call associate_and_create_section!' do
      subject
        .should_receive(:associate_and_create_section!)
        .with(example_section, department, course, instructor)
    end

    after(:all) do
      subject.create_section!(example_section)
    end

  end

  describe 'find_or_create_department!' do

    before(:all) do
      Department.stub_chain(:where, :first_or_create).and_return department
    end
 
    it 'should return a department' do
      subject.find_or_create_department!(example_section[:course_dept])
        .should == department
    end

    context 'inner method logic' do

      it 'should call Department.where with proper params' do
        Department.should_receive(:where).with(:abbreviation => example_section[:course_dept])
      end

      it 'should call Department.first_or_create' do
        Department.should_receive(:first_or_create)
      end

      after(:all) do 
        subject.find_or_create_department!(example_section[:course_dept])
      end

    end

  end

  describe 'find_or_create_course!' do

    before(:all) do
      Course.stub_chain(:where, :first_or_create).and_return course
    end

    it 'should return a course' do
      subject.find_or_create_course!(example_section[:course_title], example_section[:course_number])
        .should == course
    end

    context 'inner method logic' do

      it 'should call Course.where with proper params' do
        Course.should_receive(:where)
          .with(:title => example_section[:course_title], :number => example_section[:course_number])
      end

      it 'should call Course.first_or_create' do
        Course.should_receive(:first_or_create)
      end

    end

  end


  describe 'find_or_create_instructor!' do

    before(:all) do
      Instructor.stub_chain(:where, :first_or_create).and_return instructor
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
        Instructor.should_receive(:first_or_create)
      end

    end

  end


  describe 'associate_and_create_section!' do

    before(:all) do
      department.stub(:save!)
      course.stub(:save!)
      instructor.stub(:save!)
      Section.stub_chain(:where, :first_or_create).and_return section
    end

    context 'testing section calls' do

      it 'should call Section.where' do
        Section.should_receive(:where).with(
          :number => example_section[:section_number],
          :term => example_section[:term],
          :num_a => example_section[:count_a],
          :num_b => example_section[:count_b],
          :num_c => example_section[:count_c],
          :num_d => example_section[:count_d],
          :num_f => example_section[:count_f],
          :avg_gpa => example_section[:avg_gpa]
        )
      end

      it 'should call Section.first_or_create' do
        Section.should_receive(:first_or_create)
      end

      after(:all) do
        subject.associate_and_create_section!(example_section, department, course, instructor)
      end

    end

    context 'testing if associations were set up correctly:' do

      before(:all) do
        subject.associate_and_create_section!(example_section, department, course, instructor)
      end


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



end