require_relative "..\\image_board"
require_relative "..\\user"

describe ImageBoard do
  before :each do
    @imgboard = ImageBoard.new
  end

  describe "new" do
    it "should exist" do
      @imgboard.should_not == nil
    end

    it "should have a class of ImageBoard" do
      @imgboard.should( be_an_instance_of(ImageBoard) )
    end

  describe "data" do
    it 'should check for non-existing nickname correctly' do
      @imgboard.check_nic_exists('zero').should == false
    end

    it 'should check for existing nickname correctly' do
      user = User.new 'z', 'e', 'zero','z@gmail.com'
      @imgboard.instance_eval {@users}.push user
      @imgboard.check_nic_exists('zero').should == true
    end

    it 'should check for non-existing email correctly' do
      @imgboard.check_email_exists('z@gmail.com').should == false
    end

    it 'should check for existing email correctly' do
      user = User.new 'z', 'e', 'zero','z@gmail.com'
      @imgboard.instance_eval {@users}.push user
      @imgboard.check_email_exists('z@gmail.com').should == true
    end

    it 'should register user' do
      @imgboard.register_user 'z', 'e', 'zero', 'aaaa', 'z@gmail.com'
      @imgboard.instance_eval {@users}[0].nic.should == 'zero'
    end

    it 'should not register user with existing nic/email' do
      @imgboard.register_user('z', 'e', 'zero', 'aaaa', 'z@gmail.com')
      @imgboard.register_user('z', 'e', 'zero', 'aaaa', 'z@gmail.com').should == false
    end

    it 'should not register user with badly formated email' do
      @imgboard.register_user('z', 'e', 'zero', 'aaaa', 'z@gmail.').should == false
    end

    it 'should not register user with bad admin code' do
      @imgboard.instance_eval {@admin_code = (Digest::SHA2.new << 'test').to_s}
      @imgboard.register_user('z', 'e', 'zero', 'aaaa', 'z@gmail.com', 'uno').should == false
    end

    it 'should register user with good admin code' do
      @imgboard.instance_eval {@admin_code = (Digest::SHA2.new << 'test').to_s}
      @imgboard.register_user('z', 'e', 'zero', 'aaaa', 'z@gmail.com', 'test').should == true
    end

    it 'should login user correctly' do
      @imgboard.register_user'z', 'e', 'zero', 'aaaa', 'z@gmail.com'
      @imgboard.try_login('zero', 'aaaa').should( be_an_instance_of(User) )
    end

    it 'should fail to login user correctly' do
      @imgboard.try_login('zero', 'aaaa').should == nil
    end

    it 'should find user' do
      @imgboard.register_user'z', 'e', 'zero', 'aaaa', 'z@gmail.com'

      @imgboard.get_user(@imgboard.instance_eval {@users}[0].get_id).should_not == nil
    end
    describe 'images' do
      it 'should upload image' do
        user = User.new 'z', 'e', 'zero','z@gmail.com'
        @imgboard.upload_image user, 'C:\\a.jpg', []
      end
    end
  end

  end
end