class User
  attr_accessor :name, :surname, :nic, :email, :data

  def initialize name, surname, nic, email
    @name = name
    @surname = surname
    @nic = nic
    @email = email
    @data = {:skype => "", :tel => "", :about => "",
             :ppage => "", :addendum => ""}
  end

  def add_data data = {}
    @data.each_key do |key|
      if data.has_key? key
        @data[key] = data[key]
      end
    end
  end

  def get_data key
    @data[key]
  end
end