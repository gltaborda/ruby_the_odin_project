require './lib/player'


describe Player do
  
  describe "#input_column" do
    it "puts its token in the desired column" do
      player = Player.new("●", "Carlitos")
      auxiliar = player.input_column
      board = Board.new
      expect(board.insert_token_in_column(player.token, auxiliar)).to eql([5, auxiliar - 1])
      board.display
    end
  end
end