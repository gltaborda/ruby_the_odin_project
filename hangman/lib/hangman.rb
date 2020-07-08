require_relative "serializable"


class Hangman
  include Serializable
  
  attr_reader :encrypted_word, :secret_word, :turns
  attr_accessor :incorrect_letters

  def initialize
    @secret_word = get_secret_word
    @turns = 7
    @incorrect_letters = []
    @encrypted_word = encrypt
  end

  def get_secret_word
    dictionary = File.readlines('5desk.txt', chomp: true)
    dictionary.select! do |word|
      word.length.between?(5,12)
    end
    dictionary.sample.upcase.chars
  end
  
  def encrypt
    secret_word.map {|element| "_"}
  end

  def decrypt(guess)
    secret_word.each_with_index do |current_char, index|
      if current_char == guess
        encrypted_word[index] = guess
      end
    end
  end

  def play_game
    check_load
    greet
    until over? do
      play_turn
    end
    check_result
  end
  
  def greet
    puts "Welcome to hangman, you can save at any time by typing save."
    puts "Below the secret word to guess you'll see the letters you " \
         "guessed that aren't in it."
    puts "Your word to guess is: "
  end

  def play_turn
    display_stats
    guess = gets.chomp.upcase
    check_save(guess)
    while invalid?(guess)
      print "You entered an invalid guess or an already guessed letter, try again: "
      guess = gets.chomp.upcase
    end
    update(guess)
  end

  def display_stats
    puts self.encrypted_word.join(' ')
    puts "Incorrect letters: #{self.incorrect_letters.join(",")}"
    print "You have #{self.turns} turns left, choose a letter to guess: "
  end

  def invalid?(guess)
    (self.encrypted_word.include?(guess)) || (self.incorrect_letters.include?(guess) || guess.length > 1)
  end

  def update(guess)
    if self.secret_word.include?(guess)
      self.decrypt(guess)
      self.encrypted_word.join(' ')
    else
      self.incorrect_letters.push(guess)
      @turns -= 1
    end
  end

  def over?
    win? || lose?
  end

  def win?
    self.secret_word == self.encrypted_word
  end

  def lose?
    self.turns == 0
  end

  def check_result
    if win?
      puts "Congratulations, you guessed the word #{self.secret_word.join}"
    else
      puts "You lost, the word was #{self.secret_word.join}"
    end
  end

  def save_game
    Dir.mkdir("saved_games") unless Dir.exists?("saved_games")
    saved_game = "saved_games/saved_game"
    File.open(saved_game, "w") {|file| file.puts self.serialize}
    puts "\nSaving game.."
    sleep(1)
    puts "\nGame Saved! Goodbye"
    exit
  end
  
  def check_save(input)
    save_game if input == "SAVE"
  end
  
  def load_game
    saved_game = "saved_games/saved_game"
    data = File.read(saved_game)
    self.unserialize(data)
    puts "\nLoading saved game.."
    sleep(1)
  end
  
  def check_load
    if File.exists?("saved_games/saved_game")
      print "Do you want to load a saved game? (Y/N): "
      input = gets.chomp.upcase
      load_game if input == "Y"
    end
  end
end

hangman = Hangman.new
hangman.play_game