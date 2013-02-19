require 'spec_helper'
require 'section_creator'

describe SectionCreator do

  let!(:sections) {FactoryGirl.build_list(:crawled_data, 10)}
  let(:example_section) {sections.first}

  subject do
    SectionCreator.new(sections)
  end

  describe 'initialize' do
    its(:sections) { should == sections }
  end

  describe 'create_sections!' do
    it 'should call create_section! on each section' do
      sections.each do |section|
        subject.should_receive(:create_section!).with(section)
      end
    end
  end

  describe 'create_section!' do

    let(:department) {FactoryGirl.build(:department)}
    let(:course) {FactoryGirl.build(:course)}
    let(:instructor) {FactoryGirl.build(:instructor)}

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

  end

end