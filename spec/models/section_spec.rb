require 'spec_helper'

describe Section do
  it {should belong_to :instructor}
  it {should belong_to :course}
  it {should have_one :department}
end
