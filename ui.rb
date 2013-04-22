class UI

  def initialize image_board
    @image_board = image_board
    show_greet
    @input = get_input_line.chomp
    while @input != 'exit'
      case @input
        when 'register'
          register
        when 'help'
          show_greet
        else
          puts 'Command not found! type in help'
      end
      @input = get_input_line.chomp
    end

  end

  def register
    puts 'Input following:'
    print 'Name: '
    name = gets.chomp
    print 'Surname: '
    surname = gets.chomp
    print 'Nickname: '
    nic = gets.chomp

    image_board.register
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