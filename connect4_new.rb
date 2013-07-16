require_relative 'players'
require_relative 'board'

class Connect4

  attr_accessor :board, :players

  def initialize
    system("clear")
    @board = Board.new
    system("clear")
    @players = Players.new
  end


  def begin_game
    system("clear")
    take_turn(players.player1)
  end


  def take_turn(player)
    while true
      puts "\n"
      board.display_board
      puts "\n#{player.values.first}, place your \"#{player.keys.first}\". (A-#{board.last_column})"
      move = gets.chomp.upcase

      if move_valid?(move)
        piece = player.keys.first
        board.make_move(move, piece)
        break
      else
        system("clear")
        puts "Please make a valid move."
      end
    end

    system("clear")

    if game_over?(player, move)
      new_game
    elsif player == players.player1
      take_turn(players.player2)
    else
      take_turn(players.player1)
    end

  end


  def move_valid?(key)
    current_board = board.board
    if current_board.include?(key)
      if current_board[key].length < board.num_rows
        true
      else
        false
      end
    else
      false
    end
  end


  def game_over?(player, move)
    if winner?(player, move)
      winner(player)
      true
    elsif stalemate?
      stalemate
      true
    else
      false
    end
  end


  def winner?(player, move)
    piece = player.keys.first
    current_board = board.board
    if vertical?(current_board, move, piece)
      true
    elsif horizontal?(current_board, move, piece)
      true
    elsif diagonal?(current_board, move, piece)
      true
    else
      false
    end
  end


  def vertical?(current_board, move, piece)
    top_4_pieces = current_board[move].last(4)
    total_matching_pieces = top_4_pieces.select { |item| item == piece }

    if total_matching_pieces.length == 4
      true
    else
      false
    end
  end


  def horizontal?(current_board, move, piece)
    row = current_board[move].length - 1

    key = "A"
    total_in_a_row = 0
    while total_in_a_row != 4 && key <= board.last_column
      if current_board[key][row] == piece
        total_in_a_row += 1
      else
        total_in_a_row = 0
      end
      key.next!
    end

    if total_in_a_row == 4
      true
    else
      false
    end
  end


  def diagonal?(current_board, move, piece)
    column = current_board.keys.index(move)
    row = current_board[move].length - 1

    if diagonal_up?(current_board, row, column, piece)
      true
    elsif diagonal_down?(current_board, row, column, piece)
      true
    else
      false
    end
  end


  def diagonal_up?(current_board, row, column, piece) # from left to right
    current_row, current_column_key = diagonal_up_starting_points(current_board, row, column)

    total_in_a_row = 0
    while total_in_a_row != 4 && current_column_key <= board.last_column && current_row < board.num_rows
      if current_board[current_column_key][current_row] == piece
        total_in_a_row += 1
      else
        total_in_a_row = 0
      end
      current_column_key.next!
      current_row += 1
    end

    if total_in_a_row == 4
      true
    else
      false
    end
  end


  def diagonal_up_starting_points(current_board, row, column)
    if column >= 3 && row >= 3
      starting_column_key = current_board.keys[column - 3].dup
      starting_row = row - 3
    elsif column < row
      starting_column_key = "A"
      starting_row = row - column
    elsif column > row
      starting_column_key = current_board.keys[column - row].dup
      starting_row = 0
    else
      starting_column_key = "A"
      starting_row = 0
    end

    [starting_row, starting_column_key]
  end


  def diagonal_down?(current_board, row, column, piece) # from left to right
    current_row, current_column_key = diagonal_down_starting_points(current_board, row, column)

    total_in_a_row = 0
    while total_in_a_row != 4 && current_column_key <= board.last_column && current_row >= 0
      if current_board[current_column_key][current_row] == piece
        total_in_a_row += 1
      else
        total_in_a_row = 0
      end
      current_column_key.next!
      current_row -= 1
    end

    if total_in_a_row == 4
      true
    else
      false
    end
  end


  def diagonal_down_starting_points(current_board, row, column)
    if column < 3
      starting_column_key = "A"
      starting_row = row + column
    else
      starting_column_key = current_board.keys[column - 3].dup
      starting_row = row + 3
    end

    [starting_row, starting_column_key]
  end


  def stalemate?
    key = "A"
    current_board = board.board

    while key <= board.last_column && current_board[key].length == board.num_rows
      key.next!
    end

    if key > board.last_column
      true
    else
      false
    end
  end


  def winner(player)
    puts "\n"
    board.display_board
    puts "\n\nWinner, Winner, Chicken Dinner!!!!!"
    puts "#{player.values.first} has won the game."
  end


  def stalemate
    puts "\n"
    board.display_board
    puts "\n\nTwo rams butt heads."
    puts "Stalemate."
  end


  def new_game
    puts "\nDo you want to play again? (y/n)"
    if gets.chomp.downcase == "y"
      system("clear")
      @board = Board.new
      begin_game
    else
      puts "\nThanks for playing.\n\n\n\n"
    end
  end

end

game = Connect4.new
game.begin_game
