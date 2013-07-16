class Players

  attr_reader :player1, :player2

  def initialize(player1=nil, player2=nil)
    if player1 == nil
      puts "Player 1 enter name."
      @player1 = get_player1_name
    else
      @player1 = player1
    end

    if player2 == nil
      puts "Player 2 enter name."
      @player2 = get_player2_name
    else
      @player2 = player2
    end

  end

  def get_player1_name
    {:x => gets.chomp}
  end

  def get_player2_name
    player_2 = gets.chomp

    if player1.value?(player_2)
      puts "Please enter a unique name."
      get_player2_name
    else
      {:o => player_2}
    end
  end


end
