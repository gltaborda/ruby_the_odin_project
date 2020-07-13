require_relative 'piece'


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