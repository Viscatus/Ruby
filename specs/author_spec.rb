require_relative "..\\author"

describe Author do
  before :each do
    @userless_author = Author.new 'Vardas', 'Pavarde', 'email@email.com'
    @user = User.new 'Vardenis', 'Pavardenis', 'vardpav', 'v.p@gmail.com'
    @author = Author.new 'Vardas', 'Pavarde', 'email@email.com', @user
  end

  describe "new" do
    it 'should exist' do
      @author.should_not == nil
    end

    it 'should have correctly assigned data' do
      @author.name.should == 'Vardas'
      @author.surname.should == 'Pavarde'
      @author.email.should == 'email@email.com'
      @author.user.should == @user
    end
  end
end