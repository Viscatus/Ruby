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

    it "should generate id correctly" do
      id = @user.get_id
      user2 = User.new "a", "b", "n", "a2@gmail.com"
      user2.get_id.should == id+1
    end
  end

  describe "user data" do
    it "should correctly add/get additional data" do
      @user.add_data :skype => "vsvs", :tel => "246 666 44444", :about => "Bio",
                      :ppage => "google.com", :addendum => "aaaa"
      @user.get_data(:skype).should == "vsvs"
      @user.get_data(:tel).should == "246 666 44444"
      @user.get_data(:about).should == "Bio"
      @user.get_data(:ppage).should == "google.com"
      @user.get_data(:addendum).should == "aaaa"
    end
  end

  describe "user relations" do
    it "should add friend succesfully" do
      user2 = User.new "a", "b", "n", "a2@gmail.com"
      @user.add_friend user2
      @user.is_friend(user2).should == true
    end
  end

end