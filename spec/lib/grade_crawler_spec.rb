require 'spec_helper'
require 'grade_crawler'
require 'mechanize'

describe GradeCrawler do

  describe 'get_post_string' do

    # Way to test private methods that I got from SO
    def GradeCrawler.pub_get_post_string(*args)
      get_post_string(*args)
    end

    it 'should return valid post string with parameter term' do
      term = 'WS2011'
      GradeCrawler.pub_get_post_string(term).should == GradeCrawler::POST_STRING_HALF1 + term + GradeCrawler::POST_STRING_HALF2
    end

    it 'should be private method' do
      expect{GradeCrawler.get_post_string}.to raise_error NoMethodError
    end

  end

  describe 'get_current_term' do

    def GradeCrawler.pub_get_current_term
      get_current_term
    end

    it 'should return correct winter term' do
      Time.stub(:now).and_return Time.mktime(2013, 1)
      GradeCrawler.pub_get_current_term.should == 'WS2013'
    end

    it 'should return correct fall term' do
      Time.stub(:now).and_return Time.mktime(2009, 9)
      GradeCrawler.pub_get_current_term.should == 'FS2009'
    end

    it 'should return correct summer term' do
      Time.stub(:now).and_return Time.mktime(2109, 7)
      GradeCrawler.pub_get_current_term.should == 'SS2109'
    end

    it 'should return correct spring term' do
      Time.stub(:now).and_return Time.mktime(2014, 2)
      GradeCrawler.pub_get_current_term.should == 'SP2014'
    end

  end

  # Put in separate context to use before(:all) instance variables
  context 'Using sample files and output' do

    # Setup stuff used in the tests below
    before(:all) do

      @agent = Mechanize.new

      @sample_file = @agent.get_file('file:///' + Rails.root.to_s + '/spec/support/sample_grade_data.html')
      @sample_data = @agent.get_file('file:///' + Rails.root.to_s + '/spec/support/sample_grade_row.html')

      @sample_term = 'FS2012'
      @sample_post_string = GradeCrawler::POST_STRING_HALF1 + 'FS2012' + GradeCrawler::POST_STRING_HALF2

      # What example data from /spec/support/sample_grade_row.html should return
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
          :avg_gpa => 3.353
        }]

    end


    describe 'parse_site_data' do

      def GradeCrawler.pub_parse_site_data(data)
        parse_site_data(data)
      end

      it 'should return an array of fully formed class_data hashes' do

        GradeCrawler.pub_parse_site_data(@sample_data).should == @class_data

      end

    end

    describe 'request_site_data' do

      def GradeCrawler.pub_request_site_data(post_string)
        request_site_data(post_string)
      end


      # I originally wanted these to be divided into multiple tests.
      # I'm not sure if that is possible or better
      it 'should return a mechanize page of the site data' do

        Mechanize.should_receive(:new).and_return @agent

        @agent.should_receive(:post)
          .with(GradeCrawler::SITE_URI, @sample_post_string, GradeCrawler::REQUEST_HEADER)
          .and_return @sample_file

        GradeCrawler.pub_request_site_data(@sample_post_string).should == @sample_file

      end

    end

    describe 'get_grade_data' do

      it 'should return proper data for a crawl' do

        GradeCrawler.should_receive(:request_site_data).and_return @sample_data

        GradeCrawler.should_receive(:get_post_string)
          .with(@sample_term)
          .and_return @sample_post_string

        GradeCrawler.should_receive(:parse_site_data)
          .with(@sample_data)
          .and_return @class_data
        
        GradeCrawler.get_grade_data(@sample_term).should == @class_data
      end

    end



  end
end