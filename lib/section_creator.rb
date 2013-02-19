# Class to take the crawled data params and import it to models
# for each section

class SectionCreator

  attr_accessor :sections

  def initialize(sections)
    @sections = sections
  end

end