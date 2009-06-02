require 'honstats'

honstats = HonStats::API.new
char = honstats.get_character("Limi")
puts char.inspect