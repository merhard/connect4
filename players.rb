class Players

  attr_reader :player1, :player2

  def initialize
    puts "Player 1 enter name."
    @player1 = get_player1_name

    puts "Player 2 enter name."
    @player2 = get_player2_name
  end


  def get_player1_name
    {:X => gets.chomp}
  end


  def get_player2_name
    player_2 = gets.chomp

    if player1.value?(player_2)
      puts "Please enter a unique name."
      get_player2_name
    else
      {:O => player_2}
    end
  end

end
