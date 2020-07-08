class Game
  attr_accessor :board, :players
  def initialize(player1, player2)
    self.board = Board.new
    self.players = [player1, player2]
  end

  def over?
    (self.board.win(players[0].token)) || (self.board.full)  
  end

  def play_a_match
    until over? do
      board.display
      cell = players[0].play
      until board.cell_is_available(cell) do
        puts "Cell unavailable, try again."
        board.display
        cell = players[0].play
      end
      board.update_cell(cell, players[0].token)
      players.reverse!
      over?
    end
    puts "#{players[0].name} wins!"
  end
end

class Board
  attr_accessor :rows
  attr_reader :available_cells
  def initialize
    self.rows =  [[1, 2, 3],
                  [4, 5, 6],
                  [7, 8, 9]]
    @available_cells = 9
  end

  def display
    self.rows.each do |current_row|
      current_row.each do |current_cell|
        print current_cell.to_s + " "
      end
      print "\n"
    end
  end

  def to_column(cell)
    (cell-1)%3
  end

  def to_row(cell)
    (cell-1)/3
  end

  def cell_is_available(cell)
    (1..9) === rows[to_row(cell)][to_column(cell)]
  end
  
  def update_cell(cell, token)
    rows[to_row(cell)][to_column(cell)] = token
    @available_cells -= 1
  end

  def win(token)
    rows_match?(token) || columns_match?(token) || diagonals_match?(token)
  end

  def full
    available_cells == 0
  end

  def rows_match?(token)
    rows.any? { |row| row == [token, token, token] }
  end

  def columns_match?(token)
    columns = []
    3.times do |i|
      columns << [rows[0][i], rows[1][i], rows[2][i]]
    end
    columns.any? { |column| column == [token, token, token] }
  end

  def diagonals_match?(token)
    diagonals = [[rows[0][0], rows[1][1], rows[2][2]], [rows[0][2], rows[1][1], rows[2][0]]]
    diagonals.any? { |diagonal| diagonal == [token, token, token] }
  end
  
end


class Player
  attr_accessor :name
  attr_reader :token
  def initialize(name, token)
    self.name = name
    @token = token
  end
  def play()
    print "\n#{name}, insert the cell you'd like to put your #{token} into: "
    cell_number = gets.chomp.to_i
  end
end


player1 = Player.new("Carlitos","X")
player2 = Player.new("Marquitos","O")

game = Game.new(player1, player2)
game.play_a_match

=begin
class HumanPlayer < Player
  @@symbol = "X"
  
end

class AIPlayer < Player
  @@symbol = "O"
end



class Cell
  attr_accessor :value, :number
  def initialize(number)
      self.number = number
      self.value = "-"
  end
  def new_value(value)
    self.value = value
  end
    
end

celula = Cell.new(1)
=end

=begin
  def player_plays(cell, token)
    if board.cell_is_available(cell) then
      board.update_cell(cell)
    elsif 
      cell = players[0].play
    end
  end
=end

