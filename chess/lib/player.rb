class Player
  attr_reader :color, :name
  def initialize(color, name)
    @color = color
    @name = name
  end

  def move_from_to
    from = ""
    to = ""
    until (LETTERS_ARRAY.include?(from[0]) && (1..8).include?(from[1].to_i))
      print "#{name} enter the position of the #{color} piece you want to move (ex: a3, b7, etc): "
      from = gets.chomp
    end
    until (LETTERS_ARRAY.include?(to[0]) && (1..8).include?(to[1].to_i))
      print "#{name} enter the position where you want to move your #{color} piece to (ex: a3, b7, etc): "
      to = gets.chomp
    end
      from_letter = read_letters_array(from[0])
      to_letter = read_letters_array(to[0])
      [from_letter, from[1].to_i, to_letter, to[1].to_i]
  end
  def read_letters_array(letter)
    index = 0
    LETTERS_ARRAY.each_with_index do |current_letter, current_index|
      index = current_index if current_letter == letter
    end
    index
  end
end