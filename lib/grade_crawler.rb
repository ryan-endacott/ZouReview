# Crawler for the grade distribution data

require 'nokogiri'

class GradeCrawler
  attr_accessor :name
  def initialize(name)
    @name = name
  end

end