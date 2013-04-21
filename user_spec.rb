require "rspec"
require_relative "user"
describe User do

  before :each do
    @user = User.new "Vardenis", "Pavardenis", "vardpav", "v.p@gmail.com"
  end

  describe "new" do
    it "should exist" do
      @user.should_not == nil
    end

    it "should have correctly assigned parameters" do
      @user.name.should == "Vardenis"
      @user.surname.should == "Pavardenis"
      @user.nic.should == "vardpav"
      @user.email.should == "v.p@gmail.com"
    end
  end

  describe "user data" do
    it "should correctly add and get additional data" do
      @user.add_data {}
    end
  end
end