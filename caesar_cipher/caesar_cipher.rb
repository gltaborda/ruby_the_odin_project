#print "Type the string to cipher: "
#string_to_cipher = gets.chomp
#print "Type the shift to cipher with: "
#shift = gets.chomp.to_i

def caesar_cipher(string_to_cipher, shift)
  shifted_string = ""
  string_to_cipher.chars.map do |char|
    ascii = char.ord
    if ((65..90) === ascii || (97..122) === ascii) then 
      ascii += shift 
      if (ascii > 90 && ascii < 97) || (ascii > 122) then
        ascii -= 26
      end
    end
    shifted_string += ascii.chr

  end
  shifted_string
end

#p caesar_cipher(string_to_cipher, shift)