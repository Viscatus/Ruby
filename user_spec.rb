require "rspec"
require_relative "user"

describe "new" do
  before :each do
    @user = User.new "Vardenis", "Pavardenis", "vardpav", "v.p@gmail.com"
  end

  it "should create itself succesfully" do

    #To change this template use File | Settings | File Templates.
    true.should == false
  end
end