class Player
  attr_reader :token, :name
  def initialize(token, name)
    @token = token
    @name = name
  end

  def input_column
    column = 0
    loop do
      print "#{name} choose the column (1 to 7) to put your #{token} into: "
      column = gets.chomp.to_i
      break if ((column > 0) && (column < 8))
    end
    column
  end
end 