class Board

  attr_reader :board, :num_rows, :num_columns

  def initialize
    board_dimensions = get_board_dimensions
    @num_rows = board_dimensions[0]
    @num_columns = board_dimensions[1]
    @board = {}
    key = "A"
    @num_columns.times do
      @board[key] = []
      key.next!
    end
  end

  def get_board_dimensions
    puts 'Do you want a custom board?'
    puts '(standard size is 6rows by 7columns)'
    answer = gets.chomp.downcase
    if answer == 'y' || answer == 'yes'
      num_rows = get_num_rows
      num_columns = get_num_columns
      [num_rows,num_columns]
    else
      puts 'Standard size it is! (6x7)'
      [6,7]
    end
  end

  def get_num_rows
    puts 'How many rows high?'
    gets.chomp.to_i
  end

  def get_num_columns
    puts 'How many columns across?'
    gets.chomp.to_i
  end

  def display_board
    current_row = num_rows
    while current_row > 0
      print "| "
      current_column = "A"
      while current_column <= board.keys.last
        if board[current_column][current_row] == nil
          print "  "
        else
          print "#{board[current_column][current_row]} "
        end
        current_column.next!
      end
      puts "|"
      current_row -= 1
    end

    print "  "
    board.keys.each do |letter|
      print "#{letter} "
    end
    puts "\n"
  end


end
