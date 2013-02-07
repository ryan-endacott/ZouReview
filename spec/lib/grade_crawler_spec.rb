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
end