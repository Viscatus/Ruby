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
        when 'login'
          login
        when 'help'
          show_greet
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

  def show_greet
    puts 'Image Gallery Interface:'
    puts 'help - show this'
    puts 'exit - exits program'
    puts 'register - registers new user'
  end

  def output_username
    if @user == nil
      print 'Anonymous: '
    else
      print "#{@user.nic}@#{@user.is_admin ? "admin" : "user"}"
    end
  end

  def get_input_line
    output_username
    return gets
  end
end