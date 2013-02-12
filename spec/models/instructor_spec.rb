require 'spec_helper'

describe Instructor do
  it {should have_many :sections}
  it {should have_many(:courses).through :sections}
  it {should have_many(:departments).through :courses}

  it {should validate_presence_of :name}
end
