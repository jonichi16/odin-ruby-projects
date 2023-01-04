require 'date'
require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_homephone(homephone)
  homephone.gsub!(/[\D]/, '')
  if homephone.length == 10
    homephone
  elsif homephone.length == 11 && homephone[0] == '1'
    homephone[1..10]
  else
    'Invalid Number'
  end
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
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter
reg_hours = []
reg_days = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)
  homephone = clean_homephone(row[:homephone])
  regdate = row[:regdate]

  reg_date = DateTime.strptime(regdate, "%m/%d/%y %H:%M")
  reg_hours.push(reg_date.hour)
  reg_days.push(reg_date.wday)

  form_letter = erb_template.result(binding)
  save_thank_you_letter(id,form_letter)
end

def convert_day(day)
  case day
  when 1
    'Sunday'
  when 2
    'Monday'
  when 3
    'Tuesday'
  when 4
    'Wednesday'
  when 5
    'Thursday'
  when 6
    'Friday'
  when 7
    'Saturday'
  else
    'Invalid date'
  end
end

freq_hours = reg_hours.each_with_object(Hash.new(0)) {|v,h| h[v] += 1}.max_by(&:last)
freq_days = reg_days.each_with_object(Hash.new(0)) {|v,h| h[v] += 1}.max_by(&:last)

puts "Most active hour: #{freq_hours[0]}:00"
puts "Most active day: #{convert_day(freq_days[0])}"
