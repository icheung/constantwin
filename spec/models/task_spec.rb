require 'spec_helper'

describe Task do
  before(:each) do
    @valid_attributes = {
      :description => "value for description",
      :duration => Time.now,
      :owner => 1,
      :is_finished => false
    }
  end

  it "should create a new instance given valid attributes" do
    Task.create!(@valid_attributes)
  end
end
