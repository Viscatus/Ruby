class Author
  attr_accessor :name, :surname, :email, :user
  def initialize name, surname, email, user=nil
    @name = name
    @surname = surname
    @email = email
    @user = user
  end
end