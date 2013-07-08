class Connect4

  def initialize
    system("clear")
    board_create
    puts "Player 1 enter name."
    player_1 = gets.chomp
    @player_1 = {:x => player_1}
    while true
      puts "Player 2 enter name."
      player_2 = gets.chomp

      if @player_1.value?(player_2)
        puts "Please enter a unique name."
      else
        @player_2 = {:o => player_2}
        break
      end
    end
    system("clear")
    puts "Let's start the game."
    system("")
    take_turn(@player_1)
  end

  def board_create
    @board = {}
    key = "A"
    7.times do
      @board[key] = []
      key.next!
    end
  end

  def take_turn(player)
    system("clear")

    while true
      puts"\n"
      display_board
      puts "\n#{player.values[0]}, what is your move?"
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

  def display_board
    value = 5
    while value >= 0
      print "|"
      key = "A"
      while key <= "G"
        if @board[key][value] == nil
          print " "
        else
          print @board[key][value]
        end
        key.next!
      end
      value -= 1
      puts "|"
    end

    print " "
    @board.keys.each do |letter|
      print letter
    end
    puts "\n"
  end

  def checks_valid(key)
    if @board.key?(key)
      if @board[key].length < 6
        true
      else
        false
      end
    else
      false
    end
  end

  def checks_win(player, move)

    column = @board.values_at(move)[0].last(4)
    x_or_o = player.keys[0]
    checker = [x_or_o, x_or_o, x_or_o, x_or_o]
    if checker == column
      return true
    end

    row = @board.values_at(move)[0].length - 1
    i = "A"
    score = 0
    while score != 4 && i <= "G"
      if @board.values_at(i)[0][row] == x_or_o
        score += 1
      else
        score = 0
      end
      i.next!
    end
    if score == 4
      return true
    end

    false
  end

  def checks_stalemate
    key = "A"
    while key <= "G"
      if @board[key].length == 6
        key.next!
      else
        break
      end
    end
    if key > "G"
      true
    else
      false
    end
  end

  def winner(player)
    system("clear")
    puts "\n"
    display_board
    puts "\n\nWinner, Winner, Chicken Dinner!!!!!"
    puts "#{player.values[0]} has won the game."
    new_game
  end

  def stalemate
    system("clear")
    puts "\n"
    display_board
    puts "\n\nTwo rams butt heads."
    puts "Stalemate."
    new_game
  end

  def new_game
    puts "\nDo you want to play again? (y/n)"
    if gets.chomp.downcase == "y"
      board_create
      system("clear")
      puts "Lets start the game."
      take_turn(@player_1)
    else
      puts "Thanks for playing.\n\n\n\n"
    end
  end

end

Connect4.new
