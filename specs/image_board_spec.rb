require_relative "..\\image_board"

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

  end
end