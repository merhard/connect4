class Board

  attr_reader :num_rows, :last_column
  attr_accessor :board

  def initialize
    board_dimensions = get_board_dimensions
    @num_rows = board_dimensions[0]
    num_columns = board_dimensions[1]
    @board = {}
    key = "A"
    num_columns.times do
      @board[key] = []
      key.next!
    end
    @last_column = @board.keys.last
  end


  def get_board_dimensions
    puts 'Do you want a custom board? (y/n)'
    puts '(standard size is 6rows by 7columns)'
    answer = gets.chomp.downcase
    if answer == 'y'
      num_rows = get_num_rows
      num_columns = get_num_columns
      [num_rows,num_columns]
    else
      [6,7]
    end
  end


  def get_num_rows
    puts "\nHow many rows high? (min:4, max:25)"
    rows = gets.chomp.to_i
    if rows < 4 || rows > 25
      puts 'Please enter a valid number of rows.'
      get_num_rows
    else
      rows
    end
  end


  def get_num_columns
    puts "\nHow many columns across? (min:4, max:25)"
    columns = gets.chomp.to_i
    if columns < 4 || columns > 25
      puts 'Please enter a valid number of columns.'
      get_num_columns
    else
      columns
    end
  end


  def display_board
    current_row = num_rows - 1
    while current_row >= 0
      print "| "
      current_column = "A"
      while current_column <= last_column
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


  def make_move(move, piece)
    board[move].push(piece)
  end

end
