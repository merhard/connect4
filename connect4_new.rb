require_relative 'players'
require_relative 'board'

class Connect4

  attr_accessor :board, :players

  def initialize
    system("clear")
    @board = Board.new
    @players = Players.new
  end


  def begin_game
    system("clear")
    take_turn(players.player1)
  end


  def take_turn(player)
    puts "\n"
    board.display_board
    puts "\n#{player.values.first}, what is your move? (A-#{board.last_column})"
    move = gets.chomp.upcase

    if move_valid?(move)
      piece = player.keys.first
      board.make_move(move, piece)
    else
      system("clear")
      puts "Please make a valid move."
      take_turn(player)
    end

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
    if vertical?(move, piece)
      true
    elsif horizontal?(move, piece)
      true
    elsif diagonal?(move, piece)
      true
    else
      false
    end
  end


  def vertical?(move, piece)
    current_board = board.board
    top_4_pieces = current_board[move].last(4)
    total_matching_pieces = top_4_pieces.select { |item| item=piece }

    if total_matching_pieces.length == 4
      true
    else
      false
    end
  end


  def horizontal?(move, piece)
    current_board = board.board
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


  def diagonal?(move, piece)
    # refactor to check for diagonal 4 in a row
    false
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
    system("clear")
    puts "\n"
    board.display_board
    puts "\n\nWinner, Winner, Chicken Dinner!!!!!"
    puts "#{player.values.first} has won the game."
  end


  def stalemate
    system("clear")
    puts "\n"
    board.display_board
    puts "\n\nTwo rams butt heads."
    puts "Stalemate."
  end


  def new_game
    puts "\nDo you want to play again? (y/n)"
    if gets.chomp.downcase == "y"
      @board = Board.new
      begin_game
    else
      puts "Thanks for playing.\n\n\n\n"
    end
  end

end

game = Connect4.new
game.begin_game
