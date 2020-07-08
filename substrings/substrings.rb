
def substrings(sentence, word_bank)
  new_hash = Hash.new 0
  sentence.downcase.split(' ').each do |string|
    word_bank.each do |word|
      if string.include?(word) then new_hash[word] += 1 end
    end    
  end
  return new_hash
end

puts 'enter string'
str = gets.chomp.to_s;
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

p substrings(str, dictionary)