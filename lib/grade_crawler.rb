# Crawler for the grade distribution data

require 'nokogiri'
require 'mechanize'



class GradeCrawler

  POST_STRING_HALF1 = "vterm="
  POST_STRING_HALF2 = "&vinstructor=&vclass=&vdept=&vtitle=&vbool=&vcomnumb="

  SITE_URI= 'https://musis1.missouri.edu/gradedist/mu_grade_dist_intro.cfm#CGI.script.name'
  REQUEST_HEADER = {'Content-Type' => 'application/x-www-form-urlencoded'}

  def self.get_grade_data(term=get_current_term)

  end

  def self.parse_site_data(body)
  end

  def self.request_site_data(post_string)
    return Mechanize.new.post(SITE_URI, post_string, REQUEST_HEADER)
  end

  def self.get_post_string(term)
    return POST_STRING_HALF1 + term + POST_STRING_HALF2
  end

  def self.get_current_term
    now = Time.now
    cur_year = now.year

    # There may be a better way to do this..
    start_of_year = Time.mktime(cur_year)
    spring_start = Time.mktime(cur_year, 1, 15)
    summer_start = Time.mktime(cur_year, 5, 15)
    fall_start = Time.mktime(cur_year, 8, 15)
    winter_start = Time.mktime(cur_year, 12, 15)

    # Find where now is contained 
    if (start_of_year..spring_start).cover? now
      return 'WS' + cur_year.to_s
    elsif (spring_start..summer_start).cover? now
      return 'SP' + cur_year.to_s
    elsif (summer_start..fall_start).cover? now
      return 'SS' + cur_year.to_s
    elsif (fall_start..winter_start).cover? now
      return 'FS' + cur_year.to_s
    else
      return 'WS' + (cur_year + 1).to_s
    end

  end

  private_class_method :get_post_string, :get_current_term,
   :request_site_data, :parse_site_data

end