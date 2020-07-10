LETTERS_ARRAY = ["", "a", "b", "c", "d", "e", "f", "g", "h"]
ROOK_MOVES = [[1, 0], [0, 1], [-1, 0], [0, -1]]
KNIGHT_MOVES = [[2, 1], [1, 2], [-2, 1], [1, -2], [2, -1], [-1, 2], [-2, -1], [-1, -2]]
BISHOP_MOVES = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
LONG_RANGE = (1..7)
SHORT_RANGE = 1

module Moveable
  def valid_move?(new_row, new_column)
    found = false
    p difference = [new_row - current_position[0], new_column - current_position[1]]
    for i in range
      puts i
      aux = moves.collect {|x| x.collect {|y| y * i}  }
      p aux
      for j in (0..moves.size - 1)
        if difference == aux[j]
          found = true
          puts true
        end
        break if found
      end
      break if found
    end
    found
  end
end


class Piece
  attr_reader :image, :moves, :range
  attr_accessor :current_position
  def initialize(image, row, column)
    @image = image
    @moves = []
    @current_position = [row, column]
  end
  def valid_move?(new_row, new_column)
    difference = [new_row - current_position[0], new_column - current_position[1]]
    if moves.include?(difference)
      true
    else
      false
    end
  end
end

class King < Piece
  def initialize(image, row, column)
    super(image, row, column)
    @moves = ROOK_MOVES + BISHOP_MOVES
    @moved = false
  end
end

class Queen < Piece
  include Moveable
  def initialize(image, row, column)
    super(image, row, column)
    @moves = ROOK_MOVES + BISHOP_MOVES 
    @range = LONG_RANGE
  end
  
end

class Rook < Piece
  include Moveable
  def initialize(image, row, column)
    super(image, row, column)
    @moves = ROOK_MOVES
    @moved = false
    @range = LONG_RANGE
  end
end

class Knight < Piece
  def initialize(image, row, column)
    super(image, row, column)
    @moves = KNIGHT_MOVES
  end
end

class Bishop < Piece
  include Moveable
  def initialize(image, row, column)
    super(image, row, column)
    @moves = BISHOP_MOVES
    @range = LONG_RANGE
  end
end

class Pawn < Piece
  def initialize(image, pass, row, column)
    super(image, row, column)
    @moves = [[pass, 0]]
    @moved = false
  end
end

class Empty_space
  attr_reader :image
  def initialize(image)
    @image = image
  end
  
end

class Board
  attr_reader :matrix, :empty_piece

  def initialize
    #@empty_piece = Empty_piece.new("_") instead of all positions being objects they can reference the same object
    @matrix = [Array.new(9,Empty_space.new("_")), Array.new(9,Empty_space.new("_")), Array.new(9,Empty_space.new("_")),
               Array.new(9,Empty_space.new("_")), Array.new(9,Empty_space.new("_")), Array.new(9,Empty_space.new("_")),
               Array.new(9,Empty_space.new("_")), Array.new(9,Empty_space.new("_")), Array.new(9,Empty_space.new("_"))]
  end

  def display
    matrix.reverse.each_with_index do |row, index|          
      if index == 8
        puts "#{row[0].image} #{row[1]} #{row[2]} #{row[3]} "\
             "#{row[4]} #{row[5]} #{row[6]} #{row[7]} #{row[8]}"
      else
        puts "#{row[0]} #{row[1].image} #{row[2].image} #{row[3].image} #{row[4].image} "\
             "#{row[5].image} #{row[6].image} #{row[7].image} #{row[8].image}"
      end
    end
  end
  
  def load_pieces(row, index, color)
    if color == "white"
      row[1] = Rook.new("♖", index, 1)
      row[2] = Knight.new("♘", index, 2)
      row[3] = Bishop.new("♗", index, 3)
      row[4] = Queen.new("♕", index, 4)
      row[5] = King.new("♔", index, 5)
      row[6] = Bishop.new("♗", index, 6)
      row[7] = Knight.new("♘", index, 7)
      row[8] = Rook.new("♖", index, 8)
    else
      row[1] = Rook.new("♜", index, 1)
      row[2] = Knight.new("♞", index, 2)
      row[3] = Bishop.new("♝", index, 3)
      row[4] = Queen.new("♛", index, 4)
      row[5] = King.new("♚", index, 5)
      row[6] = Bishop.new("♝", index, 6)
      row[7] = Knight.new("♞", index, 7)
      row[8] = Rook.new("♜", index, 8)
    end
  end

  def load_pawns(row, index, color)
    if color == "white"
      image = "♙"
      pass = 1
    else
      image = "♟︎"
      pass = -1
    end
    for i in (1..8)
      row [i] = Pawn.new(image, pass, index, i)
    end
    
  end

  def load_letters(row)
    for i in (1..8)
      row [i] = LETTERS_ARRAY[i]
    end
  end

  def load
    counter = 0
    matrix.each_with_index do |row, index|
      row[0] = counter if (counter > 0)
      counter += 1
      case index
      when 8
        load_pieces(row, index, "black")
      when 7
        load_pawns(row, index, "black")
      when 2
        load_pawns(row, index, "white")
      when 1
        load_pieces(row, index, "white")
      when 0
        load_letters(row)
      end
    end
  end

  def move_piece(array)
    row = array[0]
    column = array[1]
    new_row = array[2]
    new_column = array[3]
    if matrix[new_row][new_column].class == Empty_space
      aux = matrix[row][column]
      matrix[row][column] = matrix[new_row][new_column]
      matrix[new_row][new_column] = aux
    else

    end
  end
end

# this method goes in player, need to get strings from from[0] and to[0]

def move_from_to
  print "Enter the position of the piece you want to move (ex: a3, b7, etc): "
  from = gets.chomp
  print "Enter the position where you want to move the piece to (ex: a3, b7, etc): "
  to = gets.chomp
  [from[0].to_i,from[1].to_i,to[0].to_i,to[1].to_i]
end


queen = Queen.new("♔", 1, 1)
puts queen.valid_move?(2, 1)

board = Board.new
board.load
board.display
board.move_piece(move_from_to)
board.display
for i in (1..8) 
  p board.matrix[8][i].image
  p board.matrix[8][i].moves
  p board.matrix[8][i].current_position
end
puts board.matrix[4][8].image

# how to kinda check valid moves, first would be the difference between
# the desired position and the actual, second would be the piece's moves
# or multiplying the array elements and checking with the difference

=begin

range = (-7..7)

found = false
for i in range
  puts i
  aux = KNIGHT_MOVES.collect {|x| x.collect {|y| y * i}  }
  for j in (0..second.size - 1)
    if first == aux[j]
      puts true
      found = true
    else
      puts false
    end
    break if found
  end
  break if found
end

=end


# check when moving a piece so it doesn't 'eat' a piece of the same color
# maybe comparing colors