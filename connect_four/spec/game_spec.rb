require './lib/game'

describe Game do

  describe "#initialize" do
    it "creates a game with a board and two players" do
      player1 = Player.new("●", "Carlitos")
      player2 = Player.new("○", "Marquitos")
      game = Game.new(player1, player2)
      expect(game.board.class).to eql(Board)
      expect(game.players[0].class).to eql(Player)
      expect(game.players[1].class).to eql(Player)
    end
  end
end