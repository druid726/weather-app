require 'nokogiri'
require 'yahoo_weatherman'

def local_weather(zipcode)
  client = Weatherman::Client.new
  weather = client.lookup_by_location(zipcode)
  
  today = Time.now.strftime('%w').to_i
  weather.forecasts.each do |forecast|
    day = forecast['date']

    weekday = day.strftime('%w').to_i

    if weekday == today
      day_name = "Today"
    elsif weekday == today + 1 
      day_name = "Tomorrow"
    else day_name = day.strftime('%A')
    end

    puts day_name + ' is going to be ' + forecast['text'].downcase +
      ' with a low of ' + ((forecast['low']*1.8+32).ceil).to_s + ' and a high of ' +
      ((forecast['high']*1.8+32).ceil).to_s + ' degrees farenheit.'
  end
end

puts "Please enter your zipcode"
zipcode = gets.to_s
my_weather = local_weather(zipcode)
