# Crawler for the grade distribution data

require 'nokogiri'



class GradeCrawler

  POST_STRING_HALF1 = "vterm="
  POST_STRING_HALF2 = "&vinstructor=&vclass=&vdept=&vtitle=&vbool=&vcomnumb="


  def self.get_post_string(term=self.get_current_term)
    return POST_STRING_HALF1 + term + POST_STRING_HALF2
  end

  private_class_method :get_post_string

end