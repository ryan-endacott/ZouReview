require 'spec_helper'
require 'grade_crawler'

describe GradeCrawler do

  it "should have accessible name attribute" do
    name1 = "fred"
    name2 = "sue"
    crawler = GradeCrawler.new(name1)
    crawler.name.should == name1
    crawler.name = name2
    crawler.name.should == name2
  end

end