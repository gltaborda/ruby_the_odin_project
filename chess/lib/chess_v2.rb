LETTERS_ARRAY = ["", "a", "b", "c", "d", "e", "f", "g", "h"]
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
      row[1] = Rook.new("♖", index, 1, color)
      row[2] = Knight.new("♘", index, 2, color)
      row[3] = Bishop.new("♗", index, 3, color)
      row[4] = Queen.new("♕", index, 4, color)
      row[5] = King.new("♔", index, 5, color)
      row[6] = Bishop.new("♗", index, 6, color)
      row[7] = Knight.new("♘", index, 7, color)
      row[8] = Rook.new("♖", index, 8, color)
    else
      row[1] = Rook.new("♜", index, 1, color)
      row[2] = Knight.new("♞", index, 2, color)
      row[3] = Bishop.new("♝", index, 3, color)
      row[4] = Queen.new("♛", index, 4, color)
      row[5] = King.new("♚", index, 5, color)
      row[6] = Bishop.new("♝", index, 6, color)
      row[7] = Knight.new("♞", index, 7, color)
      row[8] = Rook.new("♜", index, 8, color)
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
      row [i] = Pawn.new(image, pass, index, i, color)
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
    column = array[0]
    row = array[1]
    new_column = array[2]
    new_row = array[3]
    check_move = matrix[row][column].valid_move?(new_row, new_column)
    unless check_move[0].empty?
      path = make_path([row, column], check_move)
      if free_path?(matrix[row][column], path)
        if matrix[new_row][new_column].class == Empty_space
          aux = matrix[row][column]
          matrix[row][column] = matrix[new_row][new_column]
          matrix[new_row][new_column] = aux
          matrix[new_row][new_column].current_position = [new_row, new_column]
        else
          matrix[new_row][new_column] = matrix[row][column]
          matrix[new_row][new_column].current_position = [new_row, new_column]
          matrix[row][column] = Empty_space.new("_")
        end
      end
    end
  end

  def make_path(origin, move)
    path = []
    ending_condition = move[1]
    for i in (1..ending_condition)
      aux = [origin[0] + i * move[0][0], origin[1] + i * move[0][1]]
      path.push(aux)
    end
    path
  end

  def free_path?(origin, path)
    free_path = true
    destiny = matrix[path[path.size - 1][0]][path[path.size - 1][1]]
    path.each_with_index do |position, index|  
      if (index != path.size - 1) && (matrix[position[0]][position[1]].class != Empty_space)
        free_path = false
        p "ni en pedo se mueve gato"
      end
      if origin.color == destiny.color
        free_path = false
      end
    end
    free_path
  end

end

# this method goes in player, need to get strings from from[0] and to[0]

def read_letters_array(letter)
  index = 0
  LETTERS_ARRAY.each_with_index do |current_letter, current_index|
    index = current_index if current_letter == letter
  end
  index
end

def move_from_to
    print "Enter the position of the piece you want to move (ex: a3, b7, etc): "
    from = gets.chomp
    print "Enter the position where you want to move the piece to (ex: a3, b7, etc): "
    to = gets.chomp
    from_letter = read_letters_array(from[0])
    to_letter = read_letters_array(to[0])
    [from_letter, from[1].to_i, to_letter, to[1].to_i]
end




=begin
board = Board.new
queen = Queen.new("♔", 6, 6, "white")
board.display
p path = board.make_path(queen.current_position,queen.valid_move?(2, 2))
puts board.free_path?(path)
=end

p read_letters_array("e")

board = Board.new

board.load
board.display
board.move_piece(move_from_to)
board.display
p board.matrix[3][3].image
board.move_piece(move_from_to)
board.display
board.move_piece(move_from_to)
board.display
board.move_piece(move_from_to)
board.display
board.move_piece(move_from_to)
board.display


=begin
to-do
-link players with pieces or at least the king
-check for check and checkmate
-build the flow of the turns (easy)
=end