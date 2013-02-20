class Instructor < ActiveRecord::Base

  has_many :sections
  has_many :courses, :through => :sections
  has_many :departments, :through => :courses

  before_save :set_blank_name_to_staff

  private
    def set_blank_name_to_staff
      self.name = 'Staff' if self.name.nil? || self.name.empty?
    end
end
