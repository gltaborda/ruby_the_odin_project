# Mastermind game, the codemaker chooses from 6 colors to create a pattern of length 4 using any of those colors
# The codebreaker guesses a pattern and the codemaker must tell the codebreaker how many of the 4 guesses were
# exact and how many were the correct color but in a wrong position. It ends when the code is discovered
# or when 12 turns pass.

COLOR_ARRAY = ["r","g","b","y","c","m"]   #red, green, blue, yellow, cyan, magenta

class Game
  def initialize
    @player = Player.new
    @computer = Computer.new
    @turns = 0
  end
  def play_round
    puts  "Welcome to Mastermind. The objective of the game is to guess " \
          "the code that the machine will create. \nThis code consists  " \
          "in 4 positions, each of which can be one of the next 6 colors:\n" \
          "r => red, g => green, b => blue, y => yellow, c => cyan and " \
          "m => magenta.\nTo guess you must write your guess when asked. " \
          "For example: rgby meaning red-green-blue-yellow.\nAfter every " \
          "guess the computer will give you a hint. This hint can be X, " \
          "O or nothing.\nX means one guess was correct and O means that the " \
          "color was right but the position wrong.\n" \
          "The computer will build the code and the game will start."
    guess = ""
    until check_code(guess) || @turns == 12
      @turns += 1
      puts "Make your guess number #{@turns}: "
      guess = @player.make_guess
      @computer.give_hints(guess)
      #@computer.code
    end
    if check_code(guess)
      puts "You win"
    else
      puts "You lost, the code was #{@computer.code.join}"
    end
  end
  def check_code(guess)
    guess == @computer.code.join
  end
end

class Computer
  attr_reader :code
  def initialize
    @code = createCode
  end
  def createCode
    # creates an array of length 4 using a random over COLOR_ARRAY
    # defined at the beginning of the code
    4.times.map{ COLOR_ARRAY[Random.rand(6)] }
  end
  def load_guess_array(guess_array, guess)
    # parses the string guess to an array to compare it with the code
    for i in (0..3)
      guess_array[i] = guess[i] 
    end
  end
  def load_hints(hints_array, guess_array, hinted)
    # compares elements between arrays and returns an array with
    # hints, X for an exact match, O for a color out of place
    guess_array.each_with_index do |current_guess, guess_index| 
      self.code.each_with_index do |current_code, code_index|
        if ((current_code == current_guess) && !(hinted[code_index]))
          if ((code_index == guess_index) && !(hinted[code_index]))
            hints_array[code_index] = "X"            
            hinted[code_index] = true
          else
            (hints_array[code_index] = "O") if !(hints_array[code_index]);
          end
        end
      end
      #puts "Current hints: #{hints_array.join('')}"
    end
  end
  def give_hints(guess)
    hints_array = Array.new(4)
    guess_array = Array.new(4)
    hinted = Array.new(4)
    load_guess_array(guess_array, guess)
    load_hints(hints_array, guess_array, hinted)
    puts "Your hints are: #{hints_array.join('')}"
  end
end

class Player
  attr_reader :guess
  def make_guess
    @guess = gets.chomp
  end
end

game = Game.new
game.play_round
