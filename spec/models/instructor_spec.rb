require 'spec_helper'

describe Instructor do
  it {should have_many :sections}
  it {should have_many(:courses).through :sections}
  it {should have_many(:departments).through :courses}

  it 'should give a name of "Staff" if name is blank' do
    i = Instructor.new
    i.name = ''
    i.save
    i.name.should == 'Staff'
  end

  it 'should give a name of "Staff" if name is nil' do
    i = Instructor.new
    i.save
    i.name.should == 'Staff'
  end
  
end
