require 'spec_helper'

describe Course do
  it {should have_many :sections}
  it {should have_many(:instructors).through :sections}
  it {should belong_to :department}

  it {should validate_presence_of :title}
  it {should validate_presence_of :number}
end
