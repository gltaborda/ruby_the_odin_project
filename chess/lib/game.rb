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
    board.load
    board.display
    until over?
      array = players[0].move_from_to
      until board.matrix[array[1]][array[0]].color == players[0].color
        puts "You didn't pick a #{players[0].color} piece. Try again."
        array = players[0].move_from_to
      end
      board.move_piece(array)
      board.display
      players.reverse!
    end
  end

  def over?
    self.winner || draw?
  end
  def winner?(row, column)
    
  end
  def draw?
    false
  end
end