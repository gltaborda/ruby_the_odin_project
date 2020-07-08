require_relative 'game'


print "Player 1, your token will be ●, enter your name: "
name1 = gets.chomp
print "Player 2, your token will be ○, enter your name: "
name2 = gets.chomp
player1 = Player.new("●", name1)
player2 = Player.new("○", name2)

game = Game.new(player1, player2)
puts "The game has started, get 4 in a row to win!"
game.play_match

