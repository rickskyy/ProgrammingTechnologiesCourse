require "sax-machine"
require "rspec"

class Device
  include SAXMachine
  element :deviceID
  element :name
  element :origin
  element :price
  element :critical
  element :deviceType
end

text = File.read("Devices.xml")

class SAXHandler
  include SAXMachine
  elements :device, :as => :devices, :class => Device
end

# describe SAXHandler do
#   before(:all) do
#     @parser = SAXHandler.new
#     @parser.parse text
#   end

#   it "should parse the proper number of hotels" do
#     @parser.devices.count.should eq 3
#   end

#   it "should parse the hotel id of each entry" do
#     @parser.devices[0].id.should eq "1"
#   end
# end

parser = SAXHandler.new
parser.parse text

count = parser.devices.count
puts count

sorted = parser.devices.sort_by {|obj| obj.price.to_f}
for i in 0..(count - 1)
  puts sorted[i].price
end
