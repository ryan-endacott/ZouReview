require 'spec_helper'
require 'grade_crawler'
require 'mechanize'

describe GradeCrawler do

  describe 'get_post_string' do

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
      Time.stub(:now).and_return(Time.mktime(2013, 1))
      GradeCrawler.pub_get_current_term.should == 'WS2013'
    end

    it 'should return correct fall term' do
      Time.stub(:now).and_return(Time.mktime(2009, 9))
      GradeCrawler.pub_get_current_term.should == 'FS2009'
    end

    it 'should return correct summer term' do
      Time.stub(:now).and_return(Time.mktime(2109, 7))
      GradeCrawler.pub_get_current_term.should == 'SS2109'
    end

    it 'should return correct spring term' do
      Time.stub(:now).and_return(Time.mktime(2014, 2))
      GradeCrawler.pub_get_current_term.should == 'SP2014'
    end

  end

  describe 'parse_site_data' do
  end

  describe 'request_site_data' do

    def GradeCrawler.pub_request_site_data(post_string)
      request_site_data(post_string)
    end

    it 'creates a new mechanize object' do
      @agent = mechanize.new
      mechanize.should_receive(:new).and_return(@agent)
    end

    it 'sends a post request to grade site' do
      @sample_post_string = GradeCrawler::POST_STRING_HALF1 + 'FS2012' + GradeCrawler::POST_STRING_HALF2
      @sample_file = @agent.get_file('../support/sample_grade_data.html')

      @agent.should_receive(:post)
        .with(GradeCrawler::SITE_URI, @sample_post_string, GradeCrawler::REQUEST_HEADER)
        .should_return(@sample_file)
    end

    it 'should return a mechanize page of the site data' do
      GradeCrawler.pub_request_site_data(@sample_post_string).should == @sample_file
    end

  end


end