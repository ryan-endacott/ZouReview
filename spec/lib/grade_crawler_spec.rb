require 'spec_helper'
require 'grade_crawler'

describe GradeCrawler do

  describe 'get_post_string' do
    it 'should return a valid post string' do

      GradeCrawler.stub(:get_current_term).and_return 'FS2012'

      def GradeCrawler.pub_get_post_string
        get_post_string
      end

      GradeCrawler.pub_get_post_string.should == 'vterm=&vinstructor=ABAD%2CNEETU+S&vclass=&vdept=&vtitle=&vbool=&vcomnumb='

    end
  end

end