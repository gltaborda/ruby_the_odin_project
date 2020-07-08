require_relative 'board'
require_relative 'player'

class Game
  attr_reader :board, :players
  attr_accessor :winner
  def initialize(player1, player2)
    @board = Board.new
    @players = [player1, player2]
    @winner = false
  end

  def play_match
    until over?
      board.display
      current_player = players[0]
      valid_column = false
      until valid_column
        column = current_player.input_column
        valid_column = !board.full_column[column - 1]
      end
      coordinates = board.insert_token_in_column(current_player.token, column)
      self.winner = winner?(coordinates[0], coordinates[1])
      players.reverse!
    end
    if winner
      puts "#{current_player.name} won!"
    else
      puts "It's a draw!"
    end
    board.display
  end

  def over?
    self.winner || draw?
  end
  def winner?(row, column)
    board.check_win(row, column)
  end
  def draw?
    board.full?
  end
end