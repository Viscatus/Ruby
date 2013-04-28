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
      @imgboard.find_user('zero').should_not == nil
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

    it 'should find user by nic' do
      @imgboard.register_user'z', 'e', 'zero', 'aaaa', 'z@gmail.com'
      @imgboard.find_user('zero').should_not == nil
    end

    it 'should have such user in database' do
      @imgboard.register_user'z', 'e', 'zero', 'aaaa', 'z@gmail.com'
      user = @imgboard.find_user('zero')
      @imgboard.should have_such_user_id user.get_id
    end

    it 'should not have a user of higher id than the last one created' do
      @imgboard.register_user'z', 'e', 'zero2', 'aaaa', 'z@gmail.com'
      user = @imgboard.find_user('zero2')
      @imgboard.should_not have_such_user_id user.get_id+1
    end
    it 'should close succesfully' do
      lambda {
        @imgboard.close
      }.should_not raise_exception
    end

    it 'should add tag' do
      @imgboard.add_tag('t').should == true
    end
    it 'should fail to add same tag' do
      @imgboard.add_tag('t')
      @imgboard.add_tag('t').should_not == true
    end
    it 'should find tag' do
      @imgboard.add_tag('test')
      @imgboard.find_tag('test').should_not == nil
    end
  end
    describe 'images' do
      it 'should find image' do
        @imgboard.register_user'z', 'e', 'zero', 'aaaa', 'z@gmail.com'
        user = @imgboard.find_user 'zero'
        @imgboard.upload_image(user, 'C:\Users\Viscatus\RubymineProjects\Ruby\test_data\2.jpg', [])
        @imgboard.find_image(@imgboard.instance_eval{@images[-1].get_id}).should_not == nil
      end

      it 'should find image by tags' do
        @imgboard.register_user'z', 'e', 'zero', 'aaaa', 'z@gmail.com'
        user = @imgboard.find_user 'zero'
        @imgboard.upload_image(user, 'C:\Users\Viscatus\RubymineProjects\Ruby\test_data\2.jpg', ["one", "two"])
        @imgboard.find_images(["one"]).should_not == []
      end

      it 'should upload image' do
        @imgboard.register_user'z', 'e', 'zero', 'aaaa', 'z@gmail.com'
        user = @imgboard.find_user 'zero'
        @imgboard.upload_image(user, 'C:\Users\Viscatus\RubymineProjects\Ruby\test_data\2.jpg', []).should == true
      end

      it 'should upload image' do
        @imgboard.register_user'z', 'e', 'zero', 'aaaa', 'z@gmail.com'
        user = @imgboard.find_user 'zero'
        @imgboard.upload_image(user, 'C:\Users\Viscatus\RubymineProjects\Ruby\test_data\2.jpg', []).should == true
      end

      it 'should not upload image if user is nonexistatnt' do
        @imgboard.upload_image(User.new('a', 'a', 'a', 'a'), 'C:\Users\Viscatus\RubymineProjects\Ruby\test_data\2.jpg', []).should == false
      end

      it 'should raise exception if file doesn\'t exist' do
        @imgboard.register_user'z', 'e', 'zero', 'aaaa', 'z@gmail.com'
        user = @imgboard.find_user 'zero'
        lambda {
        @imgboard.upload_image(user, 'C:\Users\Viscatus\RubymineProjects\Ruby\test_data', [])
        }.should raise_exception
      end
    end
  end
  describe 'file data' do
    it 'should handle yaml reading/writing correctly' do
      @imgboard.images.push(Image.new('a.jpg', [Tag.new('test1')]))
      @imgboard.tags.push Tag.new 'test1'
      @imgboard.users.push User.new 's','p','sp','s@ss.lt'
      lambda {@imgboard.save_data}.should_not raise_exception
      @imgboard.images = Array.new
      @imgboard.tags = Array.new
      @imgboard.users = Array.new
      lambda {@imgboard.load_data}.should_not raise_exception
      @imgboard.images[0].should_not == nil
      @imgboard.tags.rindex('test1').should_not == -1
      @imgboard.users.rindex('sp').should_not == -1
    end
  end
end
RSpec::Matchers.define :have_such_user_id do |expected|
  match do |actual|
      lambda {
          actual.instance_eval {@users}.each do |i|
            return true if i.get_id == expected
          end
        return false
      }.call
  end
end