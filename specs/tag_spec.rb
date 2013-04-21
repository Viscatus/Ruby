require_relative "..\\tag"

describe Tag do
  before :each do
    @tag = Tag.new 'zyme'
  end

  describe "new" do
    it "should exist" do
      @tag.should_not == nil
    end

    it "should have a class of Tag" do
      @tag.should( be_an_instance_of(Tag) )
    end

    it "should have correctly assigned data" do
      @tag.should == 'zyme'
    end

    it "should have correctly generated id" do
      tag1 = Tag.new 'zyme'
      tag2 = Tag.new 'zyme2'
      tag2.get_id.should == tag1.get_id + 1
    end

    it "should have correctly generated id if synonymous tag" do
      tag1 = Tag.new 'zyme', nil, nil, 'lt'
      tag2 = Tag.new 'tag',  tag1, nil, 'en'
      tag2.get_id.should == tag1.get_id
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
      tag1 = Tag.new 'zyme2', nil, @tag
      tag1.should == @tag
    end

    it "should return true if one tag is more than 1 level parent of another" do
      tag1 = Tag.new 'zyme2', nil, @tag
      tag2 = Tag.new 'zyme3', nil, tag1
      tag2.should == @tag
    end

    it "should return false if one tag have no comparable parents" do
      tag1 = Tag.new 'zyme2', nil, @tag
      tag2 = Tag.new 'zyme3', nil, tag1
      tag3 = Tag.new 'zyme4', nil, @tag
      tag3.should_not == tag2
    end
  end
end