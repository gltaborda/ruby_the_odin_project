require './lib/board'

describe Board do
  
  describe "#full?" do
    it "shows a new board as not full" do
      board = Board.new
      expect(board.full?).to eql(false)
    end
  end
  describe "#insert_token" do
    it "inserts a token in the column of the board" do
      board = Board.new
      
      expect(board.insert_token_in_column("●",3)).to eql([5, 2])
    end
    it "inserts in the next row when it's occupied" do
      board = Board.new
      board.insert_token_in_column("○",3)
      expect(board.insert_token_in_column("●",3)).to eql([4, 2])
    end
    it "doesn't insert when the column is full" do
      board = Board.new
      board.insert_token_in_column("●",3)
      board.insert_token_in_column("●",3)
      board.insert_token_in_column("●",3)
      board.insert_token_in_column("●",3)
      board.insert_token_in_column("●",3)
      board.insert_token_in_column("●",3)
      board.insert_token_in_column("○",3)
      expect(board.array[0][2]).to eql("●")
    end
  end

  describe "#check_win_row_or_column" do
    it "checks if the row win conditions is met" do
      board = Board.new
      board.insert_token_in_column("○",1)
      board.insert_token_in_column("○",2)
      board.insert_token_in_column("○",3)
      board.insert_token_in_column("●",4)
      board.insert_token_in_column("●",5)
      board.insert_token_in_column("●",6)
      auxiliar_array = board.insert_token_in_column("●",7)
      expect(board.check_win_row_or_column("row", auxiliar_array[0])).to eql(true)
    end

    it "checks if the column win conditions is met" do
      board = Board.new
      board.insert_token_in_column("○",7)
      board.insert_token_in_column("○",7)
      board.insert_token_in_column("●",7)
      board.insert_token_in_column("●",7)
      board.insert_token_in_column("●",7)
      auxiliar_array = board.insert_token_in_column("●",7)
      expect(board.check_win_row_or_column("column", auxiliar_array[1])).to eql(true)
    end
  end

  describe "#check_diagonals" do
    it "checks if the forwards diagonal win conditions is met" do
      board = Board.new
      board.insert_token_in_column("○",4)
      board.insert_token_in_column("○",4)
      board.insert_token_in_column("○",4)
      board.insert_token_in_column("○",4)
      board.insert_token_in_column("○",4)
      board.insert_token_in_column("○",3)
      board.insert_token_in_column("○",3)
      board.insert_token_in_column("○",3)
      board.insert_token_in_column("○",3)
      board.insert_token_in_column("○",2)
      board.insert_token_in_column("○",2)
      board.insert_token_in_column("○",2)
      board.insert_token_in_column("○",1)
      board.insert_token_in_column("○",1)
      board.insert_token_in_column("●",4)
      board.insert_token_in_column("●",3)
      board.insert_token_in_column("●",2)
      auxiliar_array = board.insert_token_in_column("●",1)
      board.display
      expect(board.check_diagonals(auxiliar_array[0],auxiliar_array[1])).to eql(true)
    end
  end

  describe "#check_diagonals" do
    it "checks if the backwards diagonal win conditions is met" do
      board = Board.new
      board.insert_token_in_column("○",4)
      board.insert_token_in_column("○",4)
      board.insert_token_in_column("○",4)
      board.insert_token_in_column("○",4)
      board.insert_token_in_column("○",4)
      board.insert_token_in_column("○",5)
      board.insert_token_in_column("○",5)
      board.insert_token_in_column("○",5)
      board.insert_token_in_column("○",5)
      board.insert_token_in_column("○",6)
      board.insert_token_in_column("○",6)
      board.insert_token_in_column("○",6)
      board.insert_token_in_column("○",7)
      board.insert_token_in_column("○",7)
      board.insert_token_in_column("●",4)
      board.insert_token_in_column("●",5)
      board.insert_token_in_column("●",6)
      auxiliar_array = board.insert_token_in_column("●",7)
      board.display
      expect(board.check_diagonals(auxiliar_array[0],auxiliar_array[1])).to eql(true)
    end
  end

  describe "#check_win" do
    it "checks if any of the win conditions are met" do
      board = Board.new
      board.insert_token_in_column("○",1)
      board.insert_token_in_column("●",3)
      board.insert_token_in_column("●",3)
      board.insert_token_in_column("●",4)
      board.insert_token_in_column("●",4)
      board.insert_token_in_column("○",2)
      board.insert_token_in_column("○",2)
      board.insert_token_in_column("●",1)
      board.insert_token_in_column("●",1)
      board.insert_token_in_column("●",1)
      auxiliar_array = board.insert_token_in_column("●",1)
      expect(board.check_win(auxiliar_array[0],auxiliar_array[1])).to eql(true)
    end
  end
  
end
