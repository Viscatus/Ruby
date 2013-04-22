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
          code = gets.chomp
          register code
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
    print 'Email: '
    email = gets.chomp
    while (@image_board.check_nic_exists nic)||
           !(email =~ /^[\w\.=-]+@[\w\.-]+\.[\w]{2,3}$/)
      print 'Email is taken or bad format! please retry: '
      email = gets.chomp
    end
    @image_board.register_user(name, surname, nic, email, admin_code)
  end

  def show_greet
    puts 'Image Gallery Interface:'
    puts 'help - show this'
    puts 'exit - exits program'
  end

  def output_username
    if @user == nil
      print 'Anonymous: '
    else
      print "#{@user.nic}"
    end
  end

  def get_input_line
    output_username
    return gets
  end
end