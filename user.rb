require 'digest/sha2'
#noinspection RubyClassVariableUsageInspection
class User
  attr_accessor  :nic

  @@id = 0

  def initialize(name, surname, nic, email, admin=false)
    @admin = admin
    @nic = nic
    @data = {:name => name, :surname => surname, :email => email, :skype => '',
             :tel => '', :about => '', :ppage => '', :addendum => ''}
    @privacy = {:name => 0, :surname => 0, :email => 0, :skype => 0,
                 :tel => 0, :about => 0, :ppage => 0, :addendum => 0}
    @password = nil
    @friend_list = Array.new
    @favorites = Array.new
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

  def get_data(key, user=nil, anon = false)
    return @nic if key == :nic
    if ((user == nil)&&(!anon)) ||
        ((user != nil)&&(user.is_admin)) ||
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
    args.each { |i| false unless add_friend i }
    true
  end

  def remove_friend (user)
    if (!is_friend user)
      false
    else
      @friend_list.delete_at(@friend_list.rindex(user))
      true
    end
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

  def get_privacy(key, user=nil)
    if ((user == nil) ||
        (user.is_admin))
      return @privacy[key]
    end
    nil
  end

  def set_password(pass)
    @password = Digest::SHA2.new
    @password << pass
  end

  def has_password
    @password.instance_of? Digest::SHA2
  end

  def test_password(pass)
    return false if (!has_password)
    pass2 = Digest::SHA2.new
    pass2 << pass
    (@password.to_s == pass2.to_s)
  end

  def add_favorite(obj)
    if is_favorite obj
      false
    else
      @favorites.push(obj)
      true
    end
  end

  def add_favorites (*args)
    args.each { |i| false unless add_favorite i }
    true
  end

  def delete_favorite(obj)
    if is_favorite obj
      @favorites.delete_at(@favorites.rindex(obj))
      true
    else
      false
    end
  end

  def delete_favorite_i(obj)
    return @favorites.delete_at(obj) != nil
  end

  def is_favorite(obj)
    @favorites.rindex(obj) != nil
  end

  def each_favorite
    @favorites.each { |i| yield(i)}
  end


  def is_admin
    @admin
  end
end