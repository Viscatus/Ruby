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

  end

  def set_user_priv

  end

  def print_single_privacy priv
    if priv == 0
      print 'private'
    elsif priv == 1
      print 'friends-only'
    elsif priv == 2
      print 'public'
    end
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