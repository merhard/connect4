require_relative 'players'
require_relative 'board'

class Connect4

  attr_accessor :board, :players

  def initialize
    system("clear")
    @board = Board.new
    @players = Players.new
  end

  def begin
    take_turn(players.player1)
  end

  def take_turn(player)
    system("clear")

    while true
      puts"\n"
      board.display_board
      last_column = board.board.keys.last
      puts "\n#{player.values.first}, what is your move? (A-#{last_column})"
      move = gets.chomp.upcase

      unless checks_valid(move)
        system("clear")
        puts "Please make a valid move."
      else
        break
      end
    end

    @board[move].push(player.keys[0])

    if checks_win(player, move)
      return winner(player)
    elsif checks_stalemate
      return stalemate
    else
      if player.keys == [:x]
        take_turn(@player_2)
      else
        take_turn(@player_1)
      end
    end
  end


end

game = Connect4.new
game.begin
