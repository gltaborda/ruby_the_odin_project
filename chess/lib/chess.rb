LETTERS_ARRAY = ["X", "a", "b", "c", "d", "e", "f", "g", "h"]
ROOK_MOVES = [[1, 0], [0, 1], [-1, 0], [0, -1]]
KNIGHT_MOVES = [[2, 1], [1, 2], [-2, 1], [1, -2], [2, -1], [-1, 2], [-2, -1], [-1, -2]]
BISHOP_MOVES = [[1, 1], [1, -1], [-1, 1], [-1, -1]]

class Piece
  attr_reader :image, :moves, :current_position
  def initialize(image, row, column)
    @image = image
    @moves = []
    @current_position = [row, column]
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
  def initialize(image, row, column)
    super(image, row, column)
    @moves = ROOK_MOVES + BISHOP_MOVES
  end
end

class Rook < Piece
  def initialize(image, row, column)
    super(image, row, column)
    @moves = ROOK_MOVES
    @moved = false
  end
end

class Knight < Piece
  def initialize(image, row, column)
    super(image, row, column)
    @moves = KNIGHT_MOVES
  end
end

class Bishop < Piece
  def initialize(image, row, column)
    super(image, row, column)
    @moves = BISHOP_MOVES
  end
end

class Pawn < Piece
  def initialize(image, pass, row, column)
    super(image, row, column)
    @moves = [[pass, 0]]
    @moved = false
  end
end

class Empty_piece
  attr_reader :image
  def initialize(image)
    @image = image
  end
  
end

class Board
  attr_reader :matrix, :empty_piece

  def initialize
    #@empty_piece = Empty_piece.new("_") instead of all positions being objects they can reference the same object
    @matrix = [Array.new(9,Empty_piece.new("_")), Array.new(9,Empty_piece.new("_")), Array.new(9,Empty_piece.new("_")),
               Array.new(9,Empty_piece.new("_")), Array.new(9,Empty_piece.new("_")), Array.new(9,Empty_piece.new("_")),
               Array.new(9,Empty_piece.new("_")), Array.new(9,Empty_piece.new("_")), Array.new(9,Empty_piece.new("_"))]
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
  

end

board = Board.new
board.load
board.display
for i in (1..8) 
  p board.matrix[8][i].image
  p board.matrix[8][i].moves
  p board.matrix[8][i].current_position
end
puts board.matrix[4][8].image
