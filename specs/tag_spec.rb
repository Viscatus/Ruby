require_relative "..\\tag"

describe Tag do
  before :each do
    @tag = Tag.new 'zyme'
  end

  describe "new" do
    it "should exist" do
      @tag.should_not == nil
    end

    it "should have correctly assigned data" do
      @tag.should == 'zyme'
    end
  end

  describe "compare" do
    it "should compare two equal tags correctly" do
      tag1 = Tag.new 'zyme'
      @tag.should == tag1
    end

    it "should compare two different tags correctly" do
      tag1 = Tag.new 'zyme2'
      @tag.should_not == tag1
    end

    it "should return true if one tag is a parent of another" do
      tag1 = Tag.new 'zyme2', @tag
      tag1.should == @tag
    end

    it "should return true if one tag is a 2-level parent of another" do
      tag1 = Tag.new 'zyme2', @tag
      tag2 = Tag.new 'zyme3', tag1
      tag2.should == @tag
    end

    it "should return false if one tags have no comparable parents" do
      tag1 = Tag.new 'zyme2', @tag
      tag2 = Tag.new 'zyme3', tag1
      tag3 = Tag.new 'zyme4', @tag
      tag3.should_not == tag2
    end
  end
end