class User
  attr_accessor :name, :surname, :nic, :email

  def initialize name, surname, nic, email
    @name = name
    @surname = surname
    @nic = nic
    @email = email
  end
end