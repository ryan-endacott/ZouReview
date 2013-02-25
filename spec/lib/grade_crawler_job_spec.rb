require 'spec_helper'
require 'section_creator'
require 'grade_crawler'
require 'grade_crawler_job'


describe GradeCrawlerJob do
  describe 'perform' do

    let!(:section_creator) { SectionCreator.new(:fake_data => 'lol') }
    let(:grade_crawler_job) { GradeCrawlerJob.new 'FS2010' }

    before(:each) do
      GradeCrawler.stub(:get_grade_data)
      SectionCreator.stub(:new).and_return section_creator
      section_creator.stub(:create_sections!)
    end

    # Not the best tests, but they'll work for now

    it 'should crawl grade data' do
      GradeCrawler.should_receive(:get_grade_data)
    end

    it 'should create a section creator' do
      SectionCreator.should_receive(:new)
    end

    it 'should call create_sections on the section creator' do
      section_creator.should_receive(:create_sections!)
    end

    after(:each) do
      grade_crawler_job.perform
    end

  end
end