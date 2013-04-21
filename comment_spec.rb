require_relative "comment"

describe Comment do

  before :each do
    @user_source = User.new 'Vardenis', 'Pavardenis', 'vardpav', 'v.p@gmail.com'
    @user_dest = User.new 'Vardenis', 'Pavardenis', 'vardpav', 'v.p@gmail.com'
    @comment = Comment.new 'tekstas', @user_source,@user_dest
  end

  describe "new" do
    it "should exist" do
      @comment.should_not == nil
    end

    it "should have correctly assigned data" do
      @comment.text.should == 'tekstas'
      @comment.source.should == @user_source
      @comment.destination.should == @user_dest
    end
  end
end