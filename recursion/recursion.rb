def factorial(n)
  if n < 1 
    result = 1
  else
    result = factorial(n-1) * n
  end
  result
end

#puts factorial(1)


def palindrome(string)
  if string.length <= 1
    true
  else
    (string[0] == string[-1]) && (palindrome(string[1..-2]))
  end
end

#puts palindrome("acacacacaca")

def bottles_of_beer(n)
  if n == 0
    puts "No more bottles of beer on the wall"
  else
    puts "#{n} bottles of beer on the wall"
    bottles_of_beer(n-1)
  end
end

#puts bottles_of_beer(10)

def fibonacci(n)
  if n == 0 || n == 1
    n
  else
    fibonacci(n-1) + fibonacci(n-2)
  end
end

#puts fibonacci(10)

=begin
roman_mapping = {
  1000 => "M",
  900 => "CM",
  500 => "D",
  400 => "CD",
  100 => "C",
  90 => "XC",
  50 => "L",
  40 => "XL",
  10 => "X",
  9 => "IX",
  5 => "V",
  4 => "IV",
  1 => "I"
}

def integer_to_roman(roman_mapping, number)

end
=end