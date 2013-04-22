class UI

  def initialize image_board
    @image_board = image_board
    show_greet
    @input = get_input_line.chomp
    while @input != 'exit'
      case @input
        when 'register'
          register
        when 'register_admin'
          print 'input master password: '
          code = gets.chomp
          register code
        when 'info'
          if @user == nil
            puts 'Nothing to print!'
          else
            print_user_info
          end
        when 'getinfo'
          print_other_user_info
        when 'setinfo'
          if @user == nil
            puts 'Nothing to set!'
          else
            set_user_info
          end
        when 'setpriv'
          if @user == nil
            puts 'Nothing to set!'
          else
            set_user_priv
          end
        when 'addfriend'
          add_friend
        when 'delfriend'
          del_friend
        when 'printfriend'
          print_friend
        when 'login'
          login
        when 'logout'
          logout
        when 'help'
          show_greet
        when ''

        else
          puts 'Command not found! type in help'
      end
      @input = get_input_line.chomp
    end

  end

  def register admin_code=nil
    puts 'Input following:'
    print 'Name: '
    name = gets.chomp
    print 'Surname: '
    surname = gets.chomp
    print 'Nickname: '
    nic = gets.chomp
    while @image_board.check_nic_exists nic
      print 'Nickname is taken! please retry: '
      nic = gets.chomp
    end
    print 'Password: '
    pass = gets.chomp
    print 'Email: '
    email = gets.chomp
    while (@image_board.check_email_exists email)||
           !(email =~ /^[\w\.=-]+@[\w\.-]+\.[\w]{2,3}$/)
      print 'Email is taken or bad format! please retry: '
      email = gets.chomp
    end
    if @image_board.register_user(name, surname, nic, pass, email, admin_code)
      puts 'Successfully registered!'
    else
      puts 'Failed to register!'
    end
  end

  def set_user_info
    print 'Input key: '
    key = gets.chomp.to_sym
    if @user.get_data(key) == nil
      puts 'Bad key!'
      return false
    end
    puts "Current value #{@user.get_data(key)}"
    print "Input new: "
    val = gets.chomp
    @user.add_data(key => val)
  end

  def set_user_priv
    print 'Input key: '
    key = gets.chomp.to_sym
    if @user.get_data(key) == nil
      puts 'Bad key!'
      return false
    end
    puts "Current value #{print_single_privacy @user.get_privacy(key)}"
    print "Input new (0 - private, 1 - friends, 2 - public): "
    val = gets.chomp
    @user.set_privacy({key => (val % 3).to_i})
  end

  def print_single_privacy priv
    if priv == 0
      return 'private'
    elsif priv == 1
      return 'friends-only'
    elsif priv == 2
      return  'public'
    else
      return 'undefined'
    end
  end

  def print_single_data data
    if data == nil
      return '<forbidden>'
    elsif data == ''
      return '<empty>'
    else
      return data
    end
  end

  def print_other_user_info
    print 'Input user id: '
    uid = gets.chomp
    user = @image_board.get_user uid.to_i
    if user == nil
      puts 'Such user does not exit!'
      return false
    end
    puts "======================================"
    puts "User info for #{user.nic}: "
    puts "email: #{print_single_data(user.get_data :email, user, @user==nil)}"
    puts "Name: #{print_single_data(user.get_data :name, user, @user==nil)}"
    puts "Surname: #{print_single_data(user.get_data :surname, user, @user==nil)}"
    puts "Skype: #{print_single_data(user.get_data :skype, user, @user==nil)}"
    puts "Telephone: #{print_single_data(user.get_data :tel, user, @user==nil)}"
    puts "About: #{print_single_data(user.get_data :about, user, @user==nil)}"
    puts "Home page: #{print_single_data(user.get_data :ppage, user, @user==nil)}"
    puts "Additional information: #{print_single_data(user.get_data :addendum, user, @user==nil)}"
    puts "======================================"
  end

  def print_user_info
    puts "======================================"
    puts "User info for #{@user.nic}: "
    puts "email: #{@user.get_data :email}"
    puts "Name: #{@user.get_data :name}"
    puts "Surname: #{@user.get_data :surname}"
    puts "Skype: #{@user.get_data :skype}"
    puts "Telephone: #{@user.get_data :tel}"
    puts "About: #{@user.get_data :about}"
    puts "Home page: #{@user.get_data :ppage}"
    puts "Additional information: #{@user.get_data :addendum}"
    puts "--------------------------------------"
    puts "Privacy settings: "
    puts "email: #{print_single_privacy @user.get_privacy(:email)}"
    puts "Name: #{print_single_privacy @user.get_privacy(:name)}"
    puts "Surname: #{print_single_privacy @user.get_privacy(:surname)}"
    puts "Skype: #{print_single_privacy @user.get_privacy(:skype)}"
    puts "Telephone: #{print_single_privacy @user.get_privacy(:tel)}"
    puts "About: #{print_single_privacy @user.get_privacy(:about)}"
    puts "Home page: #{print_single_privacy @user.get_privacy(:ppage)}"
    puts "Additional information: #{print_single_privacy @user.get_privacy(:addendum)}"
    puts "======================================"
  end

  def print_friend
    if (@user == nil)
      puts 'Can\'t print friends as anonymous'
      return false
    end
    print "Friends:"
    @user.each_friend {|i| print " #{i}"}
  end

  def del_friend
    if (@user == nil)
      puts 'Can\'t delete friends as anonymous'
      return false
    end
    print 'Input friends nic: '
    fnic = gets
    user = @image_board.get_user uid.to_i
    if (@user.remove_friend user)
      puts 'Removed!'
    else
      puts 'Failed to remove friend!'
    end
  end

  def add_friend
    if (@user == nil)
      puts 'Can\'t add friends as anonymous'
      return false
    end
    print 'Input friends nic: '
    fnic = gets
    user = @image_board.get_user uid.to_i
    if (@user.add_friend user)
      puts 'Added!'
    else
      puts 'Failed to add friend!'
    end
  end

  def login
    print 'Nickname: '
    nic = gets.chomp
    print 'Password: '
    pass = gets.chomp
    @user = @image_board.try_login nic, pass
    if (@user == nil)
      puts 'Failed to login!'
    else
      puts "Welcome, #{nic}!"
    end
  end

  def logout
    @user = nil
    puts "Goodbye!"
  end

  def show_greet
    puts 'Image Gallery Interface:'
    puts 'help - show this'
    puts 'exit - exits program'
    puts 'register - registers new user'
    puts 'info - print user data'
    puts 'setinfo - edit user data'
    puts 'setpriv - edit user privacy settings'
    puts 'addfriend - add user to friends'
    puts 'printfriend - print all friends'
    puts 'delfriend - delete a friend'
    puts 'login - login to account'
  end

  def output_username
    if @user == nil
      print 'Anonymous: '
    else
      print "#{@user.nic}@#{@user.is_admin ? "admin" : "user"}: "
    end
  end

  def get_input_line
    output_username
    return gets
  end
end