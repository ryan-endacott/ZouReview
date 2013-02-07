require 'spec_helper'
require 'grade_crawler'

describe GradeCrawler do

  describe 'get_post_string' do

    def GradeCrawler.pub_get_post_string(*args)
      get_post_string(*args)
    end

    it 'should return valid post string with current term by default' do

      term = 'FS2012'
      GradeCrawler.stub(:get_current_term).and_return term

      GradeCrawler.pub_get_post_string.should == GradeCrawler::POST_STRING_HALF1 + term + GradeCrawler::POST_STRING_HALF2

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

end