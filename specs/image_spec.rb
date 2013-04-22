require_relative "..\\image"
require_relative "..\\tag"
require_relative "..\\user"
require "simplecov"
describe Image do
  before :each do
    @user = User.new 'a', 'b', 'n', 'a@a.lt'
    @image = Image.new ".\\test_data\\1.jpg",
                        [Tag.new("transparent"), Tag.new("wallpaper"),
                         Tag.new("moon"), Tag.new("space")], @user
  end

  describe "new" do
    it "should exist" do
      @image.should_not == nil
    end

    it "should have a class of Image" do
      @image.should( be_an_instance_of(Image) )
    end

    it "should have assigned image filepath" do
      @image.img_name.should == ".\\test_data\\1.jpg"
    end

    it "should generate id correctly" do
      image2 =Image.new "test_data\\2.png",
                        [Tag.new("transparent"), Tag.new("wallpaper"),
                         Tag.new("moon"), Tag.new("space")], @user
      image3 =Image.new "test_data\\3.png",
                        [Tag.new("transparent"), Tag.new("wallpaper"),
                         Tag.new("moon"), Tag.new("space")], @user
      image3.get_id.should == image2.get_id + 1
    end

    it "should initialize image paths correctly" do
      @image.upload_images
    end

    it "should change image path after uploading" do
      @image.img_name = 'test_data\\2.jpg'
      lambda {
        @image.upload_images
      }.should change(@image, :img_name)

    end

    it "should initialize www image paths correctly" do
      @image.img_name = 'http://wiki.mifsa.lt/1.12.0/skins/common/images/mifsa.png'
      @image.upload_images.should == true
    end

    it "should initialize www image paths with query correctly" do
      @image.img_name = 'http://wiki.mifsa.lt/1.12.0/skins/common/images/mifsa.png?a=a'
      @image.upload_images.should == true
    end

  end
  describe "tags" do
    it "should not fail adding a tag" do
      @image.add_tag(Tag.new "test_tag1").should == true
    end

    it "should add tag correctly" do
      @image.add_tag(Tag.new "test_tag2")
      @image.has_tag(Tag.new "test_tag2").should == true
    end

    it "shouldn't be possible to add existing tag" do
      @image.add_tag(Tag.new "test_tag3")
      @image.add_tag(Tag.new "test_tag3").should == false
    end

    it "shouldn't have all added tags" do
      t1 = Tag.new "test_tag1"
      t2 = Tag.new "test_tag2"
      t3 = Tag.new "test_tag3"
      @image.add_tag(t1)
      @image.add_tag(t2)
      @image.add_tag(t3)
      @image.tags.should include(t1,t2,t3)
    end

    it "should not have all tags if they don't match" do
      @tag_arr = [Tag.new("nontransparent"), Tag.new("asteroid"), Tag.new("space")]
      @image.has_all_tags(@tag_arr).should == false
    end

    it "should have all tags if they match" do
      @tag_arr = [Tag.new("transparent"), Tag.new("wallpaper")]
      @image.has_all_tags(@tag_arr).should == true
    end

    it "shouldn't return zero revelance if atleast one tag matches" do
      @tag_arr = [Tag.new("doesnt exist1"), Tag.new("doesnt exist2"), Tag.new("wallpaper")]
      @image.revelance(@tag_arr).should_not == 0;
    end

    it "should return 1 revelance if all tags match" do
      @tag_arr = [Tag.new("transparent"), Tag.new("wallpaper")]
      @image.revelance(@tag_arr).should == 1;
    end

    it "should return higher revelance score if more tags match" do
      @tag_arr1 = [Tag.new("transparent"), Tag.new("wallpaper"), Tag.new("doesnt exist1")]
      @tag_arr2 = [Tag.new("transparent"), Tag.new("wallpaper"), Tag.new("moon")]
      @image.revelance(@tag_arr2).should > @image.revelance(@tag_arr1);
    end

    it "should return 0 if no tags passed" do
      @image.revelance(Array.new).should == 0;
    end
  end

  describe "owner" do
    it 'should have the same owner' do
      image1 = Image.new ".\\test_data\\1.jpg",
                         [Tag.new("transparent")], @user
      image2 = Image.new ".\\test_data\\1.jpg",
                         [Tag.new("transparent")], @user
      image1.should have_same_owner image2
    end

    it 'should not have the same owner' do
      user2 = User.new 'a', 'b', 'n2', 'a@a.lt'
      image1 = Image.new ".\\test_data\\1.jpg",
                         [Tag.new("transparent")], user2
      image2 = Image.new ".\\test_data\\1.jpg",
                         [Tag.new("transparent")], @user
      image1.should_not have_same_owner image2
    end

    it "should have assigned owner" do
      @image.should have_same_owner @user
    end
  end
end

RSpec::Matchers.define :have_same_owner do |expected|
  match do |actual|
    if (expected.instance_of?(Image))
      actual.get_owner == expected.get_owner
    else
      actual.get_owner == expected
    end
  end
end