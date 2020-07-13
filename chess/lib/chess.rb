require_relative 'game'


LETTERS_ARRAY = ["", "a", "b", "c", "d", "e", "f", "g", "h"]

# this method goes in player, need to get strings from from[0] and to[0]

print "Player 1, your color will be white, enter your name: "
name1 = gets.chomp
print "Player 2, your token will be black, enter your name: "
name2 = gets.chomp
player1 = Player.new("white", name1)
player2 = Player.new("black", name2)

game = Game.new(player1, player2)
puts "The game has started, welcome to chess!"
game.play_match


=begin
board = Board.new

queen = Queen.new("♔", 6, 6, "white")
board.display
p path = board.make_path(queen.current_position,queen.valid_move?(2, 2))
puts board.free_path?(path)

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



to-do
-link players with pieces or at least the king
-check for check and checkmate
-build the flow of the turns (easy)

=end





