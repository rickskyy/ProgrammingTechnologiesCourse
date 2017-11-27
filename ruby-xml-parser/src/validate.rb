require 'rubygems'
require 'nokogiri'

xsd = Nokogiri::XML::Schema(File.read('Device.xsd'))
doc = Nokogiri::XML(File.read('Devices.xml'))

xsd.validate(doc).each do |error|
  puts error.message
end