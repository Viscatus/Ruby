class User
  attr_accessor :name, :surname, :nic, :email

  @@id = 0

  def initialize name, surname, nic, email
    @name = name
    @surname = surname
    @nic = nic
    @email = email
    @data = {:skype => "", :tel => "", :about => "",
             :ppage => "", :addendum => ""}
    @friend_list = Array.new
    @@id = @@id + 1
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

  def get_id
    @@id
  end

  def add_friend user
    if is_friend user
      false
    else
      @friend_list.push user
      true
    end
  end

  def is_friend user
    @friend_list.rindex(user) != nil
  end
end