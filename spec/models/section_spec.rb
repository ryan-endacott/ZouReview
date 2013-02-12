require 'spec_helper'

describe Section do
  it {should belong_to :instructor}
  it {should belong_to :course}
  it {should have_one :department}

  it {should validate_presence_of :num_a}
  it {should validate_presence_of :num_b}
  it {should validate_presence_of :num_c}
  it {should validate_presence_of :num_d}
  it {should validate_presence_of :num_f}
  it {should validate_presence_of :avg_gpa}
  it {should validate_presence_of :number}
  it {should validate_presence_of :term}
  it {should validate_presence_of :course}
  it {should validate_presence_of :instructor}

  it {should validate_numericality_of(:num_a).only_integer}
  it {should validate_numericality_of(:num_b).only_integer}
  it {should validate_numericality_of(:num_c).only_integer}
  it {should validate_numericality_of(:num_d).only_integer}
  it {should validate_numericality_of(:num_f).only_integer}
  it {should validate_numericality_of :avg_gpa}
end
