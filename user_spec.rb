require_relative 'user'
describe User do

  before :each do
    @user = User.new 'Vardenis', 'Pavardenis', 'vardpav', 'v.p@gmail.com'
  end

  describe 'new' do
    it 'should exist' do
      @user.should_not == nil
    end

    it 'should have correctly assigned nic' do
      @user.nic.should == 'vardpav'
    end

    it 'should generate id correctly' do
      id = @user.get_id
      user2 = User.new 'a', 'b', 'n', 'a2@gmail.com'
      user2.get_id.should == id+1
    end
  end

  describe 'user data' do
    it 'should correctly add/get additional data' do
      @user.add_data :skype => 'vsvs', :tel => '246 666 44444', :about => 'Bio',
                      :ppage => 'google.com', :addendum => 'aaaa'
      @user.get_data(:skype).should == 'vsvs'
      @user.get_data(:tel).should == '246 666 44444'
      @user.get_data(:about).should == 'Bio'
      @user.get_data(:ppage).should == 'google.com'
      @user.get_data(:addendum).should == 'aaaa'
    end
  end

  describe 'user relations' do
    it 'should add friend succesfully' do
      user2 = User.new 'a', 'b', 'n', 'a2@gmail.com'
      @user.add_friend user2
      @user.is_friend(user2).should == true
    end

    it 'should fail to add existing friend' do
      user2 = User.new 'a', 'b', 'n', 'a2@gmail.com'
      @user.add_friend user2
      @user.add_friend(user2).should == false
    end

    it 'should fail to add self as a friend' do
      @user.add_friend(@user).should == false
    end

    it 'should iterate through friends without fail' do
      @user.add_friend User.new('a', 'b', 'n', 'a2@gmail.com')
      @user.add_friend User.new('a', 'b', 'n2', 'a2@gmail.com')
      expect{ @user.each_friend {|fr| a = fr.get_id} }.to_not raise_error
    end

    it 'should iterate through friends correctly' do
      user1 = User.new('a', 'b', 'n1', 'a2@gmail.com')
      user2 = User.new('a', 'b', 'n2', 'a2@gmail.com')
      @user.add_friends user1, user2
      expect {|fr| @user.each_friend(&fr) }.to yield_successive_args(user1, user2)
    end
  end

  describe 'privacy' do
    it 'should not give access to non-public user data' do
      user1 = User.new('a', 'b', 'n1', 'a2@gmail.com')
      @user.set_privacy :name => 0, :surname => 0, :email => 0, :skype => 0,
                        :tel => 0, :about => 0, :ppage => 0, :addendum => 0
      @user.get_data(:name, user1).should == nil
    end

    it 'should give access to public user data' do
      user1 = User.new('a', 'b', 'n1', 'a2@gmail.com')
      @user.set_privacy :name => 2, :surname => 0, :email => 0, :skype => 0,
                        :tel => 0, :about => 0, :ppage => 0, :addendum => 0
      @user.get_data(:name, user1).should_not == nil
    end

    it 'should not give access to friend-only user data' do
      user1 = User.new('a', 'b', 'n1', 'a2@gmail.com')
      @user.set_privacy :name => 1, :surname => 0, :email => 0, :skype => 0,
                        :tel => 0, :about => 0, :ppage => 0, :addendum => 0
      @user.get_data(:name, user1).should == nil
    end

    it 'should give access for friend to friend-only user data' do
      user1 = User.new('a', 'b', 'n1', 'a2@gmail.com')
      @user.add_friend user1
      @user.set_privacy :name => 1, :surname => 0, :email => 0, :skype => 0,
                        :tel => 0, :about => 0, :ppage => 0, :addendum => 0
      @user.get_data(:name, user1).should_not == nil
    end

    it 'should not give access for friend to private user data' do
      user1 = User.new('a', 'b', 'n1', 'a2@gmail.com')
      @user.add_friend user1
      @user.set_privacy :name => 0, :surname => 0, :email => 0, :skype => 0,
                        :tel => 0, :about => 0, :ppage => 0, :addendum => 0
      @user.get_data(:name, user1).should == nil
    end
  end



end