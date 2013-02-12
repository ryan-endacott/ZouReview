require 'spec_helper'

describe Course do
  it {should have_many :sections}
  it {should have_many(:instructors).through :sections}
  it {should belong_to :department}
end
