ROOK_MOVES = [[1, 0], [0, 1], [-1, 0], [0, -1]]
KNIGHT_MOVES = [[2, 1], [1, 2], [-2, 1], [1, -2], [2, -1], [-1, 2], [-2, -1], [-1, -2]]
BISHOP_MOVES = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
LONG_RANGE = (1..7)
SHORT_RANGE = 1



module Moveable
  def valid_move?(new_row, new_column)
    move = []
    times = 0
    found = false
    difference = [new_row - current_position[0], new_column - current_position[1]]
    for i in range
      aux = moves.collect {|x| x.collect {|y| y * i}  }
      for j in (0..moves.size - 1)
        if difference == aux[j]
          found = true
          move = moves[j]
          times = i
        end
        break if found
      end
      break if found
    end
    [move, times]
  end
end


class Piece
  attr_reader :image, :moves, :range, :color
  attr_accessor :current_position
  def initialize(image, row, column, color)
    @image = image
    @moves = []
    @current_position = [row, column]
    @color = color
  end
  def valid_move?(new_row, new_column)
    difference = [new_row - current_position[0], new_column - current_position[1]]
    move = []
    found = false
    moves.each do |current_move|
      if current_move == difference
        move = current_move
        found = true
      end
    break if found
    end
    [move, 1]
  end
end

class King < Piece
  def initialize(image, row, column, color)
    super(image, row, column, color)
    @moves = ROOK_MOVES + BISHOP_MOVES
    @moved = false
  end
end

class Queen < Piece
  include Moveable
  def initialize(image, row, column, color)
    super(image, row, column, color)
    @moves = ROOK_MOVES + BISHOP_MOVES 
    @range = LONG_RANGE
  end
  
end

class Rook < Piece
  include Moveable
  def initialize(image, row, column, color)
    super(image, row, column, color)
    @moves = ROOK_MOVES
    @moved = false
    @range = LONG_RANGE
  end
end

class Knight < Piece
  def initialize(image, row, column, color)
    super(image, row, column, color)
    @moves = KNIGHT_MOVES
  end
end

class Bishop < Piece
  include Moveable
  def initialize(image, row, column, color)
    super(image, row, column, color)
    @moves = BISHOP_MOVES
    @range = LONG_RANGE
  end
end

class Pawn < Piece
  def initialize(image, pass, row, column, color)
    super(image, row, column, color)
    @moves = [[pass, 0]]
    @moved = false
  end
end

class Empty_space
  attr_reader :image, :color
  def initialize(image)
    @image = image
    @color = ""
  end
end