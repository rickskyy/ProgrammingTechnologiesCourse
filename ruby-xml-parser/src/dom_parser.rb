require "happymapper"

XML_STRING = File.read("Devices.xml")

class Device; end;

class Devices
  include HappyMapper
  tag 'devices'

  attribute :xmlns, String
  has_many :devices, Device, :tag => 'device'
end

class Device
  include HappyMapper
  tag 'device'

  element :deviceID, Integer
  element :name, String
  element :origin, String
  element :price, Integer
  element :critical, String
  element :deviceType, String
end

def parseXML
  Devices.parse(XML_STRING, :single => true)
end

parsed = parseXML
count = parsed.devices.count
puts "Number of devices " + String(count)

puts "Sorted by the price:"
sorted = parsed.devices.sort_by {|obj| obj.price}
for i in 0..(count - 1)
  puts String(sorted[i].deviceID) + ") " + String(sorted[i].price)
end

puts "Sorted by the energy consumption:"
types = Array.new(count)  
for i in 0..(count - 1)
  types[i] = parsed.devices[i].deviceType.split[1]
end

puts types.sort
