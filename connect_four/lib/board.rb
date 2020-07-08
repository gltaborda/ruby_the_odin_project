class Board
  attr_reader :array, :available_positions, :full_column
  def initialize
    @array = [Array.new(7,"_"),Array.new(7,"_"),Array.new(7,"_"),Array.new(7,"_"),Array.new(7,"_"),Array.new(7,"_")]
    @available_positions = 42
    @full_column = Array.new(7,false)
  end

  def full?
    available_positions == 0
  end

  def display
    @array.each do |row|
      puts "#{row[0]} #{row[1]} #{row[2]} #{row[3]} #{row[4]} #{row[5]} #{row[6]}"
    end
  end

  def insert_token_in_column(token, column)
    row = 5
    until (array[row][column - 1] == "_") || row < 0 do
      row -= 1
    end
    unless row < 0 
      array[row][column - 1] = token
      @available_positions -= 1
    end
    @full_column[column - 1] = true if row == 0
    [row, column - 1]
  end

  def check_win_row_or_column(string, row)
    if string == "column"
      auxiliar_array = array.transpose 
    else
      auxiliar_array = array
    end
    win = false
    needed_row = auxiliar_array[row]
      consecutives = 0
      for i in 0..5
        if !(needed_row[i] == "_") && (needed_row[i] == needed_row[i+1])
          consecutives += 1
          win = true if consecutives > 2
        else
          consecutives = 0
        end
        break if win
      end
    win
  end

  def check_diagonals(row, column)
    check_diagonal_win(row - column, 0, 1) || check_diagonal_win(0, column - row , 1) ||        #backwards diagonals
    check_diagonal_win(row + column - 6, 6, -1) || check_diagonal_win(0, row + column, -1)      #forwards diagonals
  end

  def check_diagonal_win(row, column, pass)
    win = false
    i = row
    j = column
    consecutives = 0
    until i > 4 || j > 5 || i < 0 || j < 0 || win
      if !(array[i][j] == "_") && (array[i][j] == array[i+1][j+pass])
        consecutives += 1
        win = true if consecutives > 2
      else
        consecutives = 0
      end
      i += 1
      j += pass
    end
    win
  end

  def check_win(row, column)
    check_win_row_or_column("row", row) || check_win_row_or_column("column", column) || check_diagonals(row, column)
  end
end