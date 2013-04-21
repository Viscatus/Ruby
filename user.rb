#noinspection RubyClassVariableUsageInspection
class User
  attr_accessor  :nic, :admin

  @@id = 0

  def initialize(name, surname, nic, email, admin=false)
    @admin = admin
    @nic = nic
    @data = {:name => name, :surname => surname, :email => email, :skype => '',
             :tel => '', :about => '', :ppage => '', :addendum => ''}
    @privacy = {:name => 0, :surname => 0, :email => 0, :skype => 0,
                 :tel => 0, :about => 0, :ppage => 0, :addendum => 0}
    @friend_list = Array.new
    @@id = @@id + 1
    @id = @@id
  end

  def add_data(data = {})
    @data.each_key do |key|
      if data.has_key? key
        @data[key] = data[key]
      end
    end
    @nic = data[:nic] if data[:nic] != nil
  end

  def get_data(key, user=nil)
    return @nic if key == :nic
    if (user == nil) ||
        (user.admin) ||
        (@privacy[key] == 2) ||
       ((@privacy[key] == 1)&&is_friend(user))
      return @data[key]
    end
    nil
  end

  def get_id
    @id
  end

  def add_friend(user)
    if (user == self) || (is_friend user)
      false
    else
      @friend_list.push user
      true
    end
  end

  def add_friends (*args)
    args.each { |i| return false unless add_friend i }
    true
  end

  def is_friend(user)
    @friend_list.rindex(user) != nil
  end

  def each_friend
    @friend_list.each { |i| yield(i)}
  end

  def set_privacy(data = {})
    @privacy.each_key do |key|
      if data.has_key? key
        @privacy[key] = data[key]
      end
    end
  end
end