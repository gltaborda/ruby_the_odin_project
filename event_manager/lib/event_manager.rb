require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")

  filename = "output/thanks_#{id}.html"

  File.open(filename,'w') do |file|
    file.puts form_letter
  end
end

puts "EventManager initialized."

=begin
# opens the file, outpus all its contents
contents = File.read "event_attendees.csv"
puts contents


# opens the file, divides its files and outputs them
lines = File.readlines "event_attendees.csv"
lines.each do |line|
  puts line.first_Name
end


# opens the file, divides by "," then gets the second
# column (first_Name) and outputs it
lines = File.readlines "event_attendees.csv"
lines.each do |line|
  columns = line.split(",")
  name = columns[2]
  puts name
end


# skips the header row
lines = File.readlines "event_attendees.csv"
lines.each_with_index do |line,index|
  next if index == 0
  columns = line.split(",")
  name = columns[2]
  puts name
end


#same as before but using ruby csv parser and symbols for columns
contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
contents.each do |row|
  name = row[:first_name]
  puts name
end


# adding zipcode, adding padding and completing missing zipcodes, 
# implementing method clean_zipcode
contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
contents.each do |row|
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  puts "#{name} #{zipcode}"
end


# using google-api gem to check legislators
contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

contents.each do |row|
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

  legislators = legislators_by_zipcode(zipcode)

  puts "#{name} #{zipcode} #{legislators}"
end
=end


contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id,form_letter)
end

puts "Finished. All leters created"
