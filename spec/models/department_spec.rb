require 'spec_helper'

describe Department do
  it {should have_many :courses}
  it {should have_many(:sections).through :courses}
  it {should have_many(:instructors).through :sections}

  it {should validate_presence_of :abbreviation}
end
