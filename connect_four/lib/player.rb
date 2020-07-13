class Player
  attr_reader :token, :name
  def initialize(token, name)
    @token = token
    @name = name
  end

  def move_from_to
    from = ""
    to = ""
    until (LETTERS_ARRAY.include?(from[0]) && (1..8).include?(from[1].to_i))
      print "Enter the position of the piece you want to move (ex: a3, b7, etc): "
      from = gets.chomp
    end
    until (LETTERS_ARRAY.include?(to[0]) && (1..8).include?(to[1].to_i))
      print "Enter the position where you want to move the piece to (ex: a3, b7, etc): "
      to = gets.chomp
    end
      from_letter = read_letters_array(from[0])
      to_letter = read_letters_array(to[0])
      [from_letter, from[1].to_i, to_letter, to[1].to_i]
  end
end